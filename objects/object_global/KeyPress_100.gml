if(DebugMode())
{
	ChangeRoomAndSetPath(room_hallwayUp, path_hallwayUp, 0.001, false);
	SetControlState(PlayerControlState.PlayerControl);
	if(GetTextboxInstance() != noone)
	{
		GetTextboxInstance().Reset();
	}
}