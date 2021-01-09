// Hard reset the game. Set the Global Game State back, and load the first room
if(keyboard_check(vk_shift))
{
	SetGlobalGameState(GlobalGameStates.MimiRoomSits);
	ChangeRooms("room_mimiRoom");
}
else
{
	// Softreset the current room
	ReloadRoom();
}