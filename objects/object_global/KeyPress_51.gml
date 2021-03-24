// Progress to sequence 3
if(keyboard_check(vk_shift) && DebugMode())
{
	SetGlobalGameState(GlobalGameStates.MimiReturnsFromDrinking);
	ChangeRoomAndSetPath(room_hallwayDown, path_hallwayDown, 0.45, true);
	if(GetTextboxInstance() != noone)
	{
		GetTextboxInstance().Reset();
	}
}