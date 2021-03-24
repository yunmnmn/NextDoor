if(DebugMode())
{
	ChangeRoomAndSetPath(room_testLevel, path_testLevel, 0.001, false);
	SetControlState(PlayerControlState.PlayerControl);
	if(GetTextboxInstance() != noone)
	{
		GetTextboxInstance().Reset();
	}
}