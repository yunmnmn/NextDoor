if(DebugMode())
{
	ChangeRoomAndSetPath(room_outside, path_outsideLow, 0.001, false);
	SetControlState(PlayerControlState.PlayerControl);
	if(GetTextboxInstance() != noone)
	{
		GetTextboxInstance().Reset();
	}
}