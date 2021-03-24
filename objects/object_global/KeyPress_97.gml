if(DebugMode())
{
	ChangeRoomAndSetPath(room_mimiRoom, path_mimiRoom, 0.001, false);
	SetControlState(PlayerControlState.PlayerControl);
	if(GetTextboxInstance() != noone)
	{
		GetTextboxInstance().Reset();
	}
}
