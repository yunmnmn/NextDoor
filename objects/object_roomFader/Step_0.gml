// TODO: write cleaner code
if(m_fadeState == FadeState.FadeIn)
{
	m_alpha -= m_fadeSpeed * DeltaTimeInMiliseconds();
	m_alpha = clamp(m_alpha, 0.0, 1.0);
	if(m_alpha <= 0.0 && !m_dirty)
	{
		// Set the dirty callback so it will only be called once
		m_dirty = true;
		
		if(m_callback != noone)
		{
			m_callback();
		}
		
		if(m_deleteAutomatically)
		{
			instance_destroy();
		}
	}
	
}
else if(m_fadeState == FadeState.FadeOut)
{
	m_alpha += m_fadeSpeed * DeltaTimeInMiliseconds();
	m_alpha = clamp(m_alpha, 0.0, 1.0);
	if(m_alpha >= 1.0 && !m_dirty)
	{
		// Set the dirty callback so it will only be called once
		m_dirty = true;
		
		if(m_callback != noone)
		{
			m_callback();
		}
		
		if(m_deleteAutomatically)
		{
			instance_destroy();
		}
	}
}
else
{
	assert(false, "Invalid fading state");
}