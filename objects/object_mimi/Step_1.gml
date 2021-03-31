// If the player is in control, let the custom variables set the build in variables
// HACK: do this here, so we can manipulate the build in variables
if(GetControlState() == PlayerControlState.PlayerControl)
{
	path_positionprevious = path_position; 
	path_position = m_position;
}

// Callback for animation played backwards
if(m_callbackAnimationEndBackwards)
{
	if(floor(image_index) == 0)
	{
		image_index = 0;
		image_speed = 1;
		var cacheCallback = m_callbackAnimationEndBackwards;
		m_callbackAnimationEndBackwards = noone;
		cacheCallback();
	}
}