// Inherit the parent event
event_inherited();

// Do the transition from day to night
if(m_startDayNightTransition)
{
	m_transition += m_transitionSpeed * DeltaTimeInMiliseconds();
	m_transition = clamp(m_transition, 0.0, 1.0);
	
	if(m_transition == 1.0)
	{
		m_startDayNightTransition = false;
	}
}

// Rumble to the beat of the music
if(m_roomMusic != noone)
{
	var musicPosition = GetSoundPosition(m_roomMusic);
	
	// NOTE: 1755 is pbm to shake the screen
	if(m_cachedDivv = noone)
	{
		m_cachedDivv =  floor(musicPosition * 1000 / 1755);
	}
	
	var divv = floor(musicPosition * 1000 / 1755);
	if(divv > m_cachedDivv)
	{
		// Shake/Pulse the screen
		PulseScreen(1.0);
		// Rumble the controller
		Rumble(0.5, 200);
		
		m_cachedDivv = divv;
	}
}
