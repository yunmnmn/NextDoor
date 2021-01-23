// TODO: write cleaner code
if(m_fadeState == FadeState.FadeIn)
{
	m_alpha -= m_fadeSpeed * DeltaTimeInMiliseconds();
	m_alpha = clamp(m_alpha, 0.0, 1.0);
	if(m_alpha <= 0.0)
	{
		if(m_callback != noone)
		{
			m_callback();
		}
		instance_destroy();
	}
	
}
else if(m_fadeState == FadeState.FadeOut)
{
	m_alpha += m_fadeSpeed * DeltaTimeInMiliseconds();
	m_alpha = clamp(m_alpha, 0.0, 1.0);
	if(m_alpha >= 1.0)
	{
		if(m_callback != noone)
		{
			m_callback();
		}
		instance_destroy();
	}
}
else
{
	assert(false, "Invalid fading state");
}