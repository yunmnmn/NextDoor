// Progress to sequence 2
if(keyboard_check(vk_shift))
{
	SetGlobalGameState(GlobalGameStates.MimiRoomSits2);
	ChangeRoomAndSetPath("room_mimiRoom", path_mimiRoom, 0.001, false);
	instance_textbox.Reset();
}