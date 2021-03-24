if(DebugMode())
{
	ChangeRoomAndSetPath(room_hallwayDown, path_hallwayDown, 0.001, false);
	SetControlState(PlayerControlState.PlayerControl);
	if(GetTextboxInstance() != noone)
	{
		GetTextboxInstance().Reset();
	}
}