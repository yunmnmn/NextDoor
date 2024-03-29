if(m_followInstance != noone || m_followPosition != noone)
{
	// TODO: recheck this all... m_followPosition could be noone
	var followPositionX = 0;
	var followPositionY = 0;
	
	if(m_followPosition != noone)
	{
		followPositionX = m_followPosition.m_x;
		followPositionY = m_followPosition.m_y;
	}
	
	// Priority should be given to the instance, and then the position
	if(m_followInstance != noone)
	{
		followPositionX = m_followInstance.x;
		followPositionY = m_followInstance.y;
	}

	var followX = clamp(followPositionX, m_viewportMinX + m_viewportHalfSize.m_x, m_viewportMaxX - m_viewportHalfSize.m_x);
	var followY = clamp(followPositionY, m_viewportMinY + m_viewportHalfSize.m_y, m_viewportMaxY - m_viewportHalfSize.m_y);

	// Desired position
	var newViewportPosX = followX - m_viewportHalfSize.m_x;
	var newViewportPosY = followY - m_viewportHalfSize.m_y;
	
	m_desiredX = newViewportPosX;
	m_desiredY = newViewportPosY;
	
	// Interpolate between starting position and new one
	m_pan += m_followSpeed * GetAverageDeltaTimeInMiliseconds();
	m_pan = max(min(m_pan, 1.0), 0.0);
	
	var interpolatedX = lerp(m_fromPosition.m_x, newViewportPosX, m_pan);
	interpolatedX = clamp(interpolatedX, min(m_fromPosition.m_x, newViewportPosX), max(m_fromPosition.m_x, newViewportPosX));
	var interpolatedY = lerp(m_fromPosition.m_y, newViewportPosY, m_pan);
	interpolatedY = clamp(interpolatedY, min(m_fromPosition.m_y, newViewportPosY), max(m_fromPosition.m_y, newViewportPosY));
	
	SetViewportPosition(interpolatedX, interpolatedY);
	
	if(abs(newViewportPosX - interpolatedX) < 6 && abs(newViewportPosY - interpolatedY) < 6)
	{
		for(var i = 0; i < ds_list_size(m_viewportCallbacks); i++)
		{
			var pathCallback = ds_list_find_value(m_viewportCallbacks, i);
			pathCallback();
		}
		ds_list_clear(m_viewportCallbacks);
	}
}

if(m_stabilized < 1.0)
{
	var shakeOffsetX = random_range(-m_shakeMagnitude, m_shakeMagnitude);
	var shakeOffsetY = random_range(-m_shakeMagnitude, m_shakeMagnitude);
	m_shakeMagnitude = lerp(m_initialShakeMagnitude, 0, m_stabilized);
	
	m_stabilized += m_stabilizeSpeed * GetAverageDeltaTimeInMiliseconds();
	m_stabilized = clamp(m_stabilized, 0, 1);
	
	camera_set_view_pos(m_viewport, m_rawPositionX + shakeOffsetX, m_rawPositionY + shakeOffsetY);
}

if(m_roomMusic != noone && m_playMusicAtInternal)
{
	var distanceX = global.audioListenerPositonX - m_playMusicAtInternalX;
	var distanceY = global.audioListenerPositonY - m_playMusicAtInternalY;
	
	var distance = sqrt((distanceX * distanceX) + (distanceY * distanceY));
	
	// Let user set max distance
	var maxDistance = m_playMusicAtInternalMaxDistance;
	
	// Linear interpolate the volume depending on the position of the emitter and listener
	var normalized = 1.0 - clamp((distance + 0.001) / maxDistance, 0.0, 1.0);
	
	// Set the volume
	SoundGain(m_roomMusic, normalized, 0.0);
}