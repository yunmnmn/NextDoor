function YoungsterClosesDoor()
{
	if(m_dirtyFlag == false)
	{
		m_dirtyFlag = true;
		
		// Close the door when Mimi hits the trigger
		instance_hallwayUpMemory.SetDoorYoungsterVisible(false);
		instance_hallwayUpMemory.SetYoungsterVisible(false);
		
		// Set the following speed back to instant
		SetViewportFollowSpeed(1.0);
	}
}

// --------- Entry Point -------------
switch(GetGlobalGameState())
{
	case GlobalGameStates.MimiWalksToOldtimer:
		YoungsterClosesDoor();
		break;
	default:
		break;
}