if(keyboard_check(vk_shift))
{
	SetGlobalGameState(GlobalGameStates.MimiRoomSits);
	ChangeRooms("room_mimiRoom");
	instance_textbox.Reset();
}