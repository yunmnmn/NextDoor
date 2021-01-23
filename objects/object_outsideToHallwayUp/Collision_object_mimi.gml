// Transition Mimi's HallwayDown -> Room when Mimi interacts with the trigger
if(keyboard_check_pressed(vk_space) && m_dirtyFlag == false)
{
	// Don't give the control to the player while transitioning
	SetControlState(PlayerControlState.PlayerNoControl);

	// Fade, and when finished, load the hallway
	var fadeEndCallback = function()
	{
		SetControlState(PlayerControlState.PlayerControl);
		PlayerChangeRoomsAndSetPath("room_hallwayUp", path_hallwayUp, 0.999, true);
	}
	CreateFader(FadeState.FadeOut, 0.01, fadeEndCallback);
}