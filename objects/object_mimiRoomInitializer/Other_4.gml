// Inherit the parent event
event_inherited();

m_transition = 0.0;
m_transitionSpeed = 0.0002;
m_startDayNightTransition = false;

function StartTransition()
{
	m_transition = 0.0;
	m_startDayNightTransition = true;
}

// Depending on the game state, set the starting transition already
if(GetGlobalGameState() < GlobalGameStates.MimiRoomSits2)
{
	m_transition = 0.0;
}
else
{
	m_transition = 1.0;
}