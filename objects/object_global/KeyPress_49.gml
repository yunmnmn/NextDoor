// Progress to sequence 1
if(keyboard_check(vk_shift) && DebugMode())
{
	SetGlobalGameState(GlobalGameStates.MimiRoomSits);
	ChangeRooms(room_mimiRoom);
	if(GetTextboxInstance() != noone)
	{
		GetTextboxInstance().Reset();
	}
}