// Progress to sequence 4
if(keyboard_check(vk_shift) && DebugMode())
{
	// Follow the player again
	instance_textbox.Reset();
	
	SetGlobalGameState(GlobalGameStates.MimiGetsChased);
	ChangeRooms(room_ending);
}