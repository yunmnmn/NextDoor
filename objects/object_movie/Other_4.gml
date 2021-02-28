m_womenWindowAnimation = movie_womenWindow;
m_framesPerSecond = sprite_get_speed(m_womenWindowAnimation);
m_frameTimeInMiliseconds = 1000.0 / m_framesPerSecond;

m_elapsedTimeInMiliseconds = 0.0;
m_drawFrame = 0;
m_callback = noone;

m_play = false;

function PlayMovie(p_callback)
{
	m_play = true;
	m_elapsedTimeInMiliseconds = 0.0;
	m_drawFrame = 0;
	
	m_callback = p_callback;
}