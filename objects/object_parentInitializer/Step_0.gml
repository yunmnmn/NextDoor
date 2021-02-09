if(m_followInstance)
{
	var followX = clamp(m_followInstance.x, m_viewportMinX + m_viewportHalfSize.m_x, m_viewportMaxX - m_viewportHalfSize.m_x);
	var followY = clamp(m_followInstance.y, m_viewportHalfSize.m_y, room_height - m_viewportHalfSize.m_y);

	// Desired position
	var newViewportPosX = followX - m_viewportHalfSize.m_x;
	var newViewportPosY = followY - m_viewportHalfSize.m_y;

	// Interpolate between current position and new one
	var currentViewportPosX = camera_get_view_x(m_viewport);
	var currentViewportPosY = camera_get_view_y(m_viewport);

	var interpolatedX = lerp(currentViewportPosX, newViewportPosX, min(m_followSpeed * DeltaTimeInMiliseconds(), 1.0));
	var interpolatedY = lerp(currentViewportPosY, newViewportPosY, min(m_followSpeed * DeltaTimeInMiliseconds(), 1.0));

	camera_set_view_pos(m_viewport, interpolatedX, interpolatedY);
}
