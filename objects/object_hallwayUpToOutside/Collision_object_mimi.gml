// Transition Mimi's HallwayDown -> Room when Mimi interacts with the trigger
if(keyboard_check_pressed(vk_space) && m_dirtyFlag == false)
{
	// Don't give the control to the player while transitioning
	SetControlState(PlayerControlState.PlayerNoControl);

	// Fade, and when finished, load the hallway
	var fadeEndCallback = function()
	{
		SetControlState(PlayerControlState.PlayerControl);
		PlayerChangeRoomsAndSetPath("room_outside", path_outsideHigh, 0.001, false);
	}
	CreateFader(FadeState.FadeOut, 0.01, fadeEndCallback);
}