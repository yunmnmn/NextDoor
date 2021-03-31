if(m_play)
{
	m_elapsedTimeInMiliseconds += DeltaTimeInMiliseconds();
	if(m_elapsedTimeInMiliseconds > m_frameTimeInMiliseconds)
	{
		m_elapsedTimeInMiliseconds = 0.0;
		m_drawFrame = clamp(m_drawFrame + 1, 0, sprite_get_number(m_womenWindowAnimation) - 1);
	}

	if(m_drawFrame == sprite_get_number(m_womenWindowAnimation) - 1)
	{
		m_play = false;
		m_elapsedTimeInMiliseconds = 0.0;
		m_drawFrame = 0;
		
		// Play the callback if there is any
		if(m_callback != noone)
		{
			var cachedCallback = m_callback;
			m_callback = noone;
			cachedCallback();
		}
		
		image_speed = 0.0;
		visible = false;
	}
}
