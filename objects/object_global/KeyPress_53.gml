// Progress to sequence 4
if(keyboard_check(vk_shift) && DebugMode())
{
	// Follow the player again
	if(GetTextboxInstance() != noone)
	{
		GetTextboxInstance().Reset();
	}
	
	SetGlobalGameState(GlobalGameStates.MimiGetsChased);
	ChangeRooms(room_ending);
}