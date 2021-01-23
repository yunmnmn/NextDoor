// Transition Mimi's Room -> HallwayDown when Mimi interacts with the trigger
if(keyboard_check_pressed(vk_space) && m_dirtyFlag == false)
{
	m_dirtyFlag = true;
	
	// Don't give the control to the player while transitioning
	SetControlState(PlayerControlState.PlayerNoControl);
	// Fade, and when finished, load the hallway
	var fadeEndCallback = function()
	{
		SetControlState(PlayerControlState.PlayerControl);
		PlayerChangeRoomsAndSetPath("room_hallwayDown", path_hallwayDown, 0.01, false);
	}
	CreateFader(FadeState.FadeOut, 0.01, fadeEndCallback);
}