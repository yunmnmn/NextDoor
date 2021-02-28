// The player has to move Mimi in order to progress
if(m_talkingFinished)
{
	if((WalkingRight() || WalkingLeft()))
	{
		// Remove the moving button prompt
		instance_global.DrawMovingPrompt(false, 0, 0);
	}
}

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