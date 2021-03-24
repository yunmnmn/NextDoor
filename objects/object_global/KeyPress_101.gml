if(DebugMode())
{
	ChangeRoomAndSetPath(room_youngsterRoom, path_youngsterRoom, 0.999, true);
	SetControlState(PlayerControlState.PlayerControl);
	if(GetTextboxInstance() != noone)
	{
		GetTextboxInstance().Reset();
	}
}