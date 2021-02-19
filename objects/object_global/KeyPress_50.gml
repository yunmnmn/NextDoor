// Progress to sequence 2
if(keyboard_check(vk_shift))
{
	SetGlobalGameState(GlobalGameStates.MimiWalksBackToRoom);
	ChangeRoomAndSetPath("room_mimiRoom", path_mimiRoom, 0.5, false);
	instance_textbox.Reset();
}