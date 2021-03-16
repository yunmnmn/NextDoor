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

// Hack: Due to the average delta frame not being calculated yet, use some pre-warm frames
if(GetGlobalGameState() == GlobalGameStates.MimiGoingToYoungster)
{
	m_warmupFrames++;
	if(m_warmupFrames > 10 && !m_pulsed)
	{
		m_pulsed = true;
		// Play the timeline that pulses the screen with a offset
		PlayTimeline(timeline_pulseScreen);
		timeline_position = 1800;
	}
}