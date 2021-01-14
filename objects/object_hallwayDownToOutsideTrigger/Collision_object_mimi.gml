// Transition Mimi's HallwayDown -> Outside(down) when Mimi interacts with the trigger
if(keyboard_check_pressed(vk_space) && m_dirtyFlag == false)
{
	// Don't give the control to the player while transitioning
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Fade, and when finished, load the hallway
	{
		var fadeEndCallback = function()
		{
			SetControlState(PlayerControlState.PlayerControl);
			ChangeRoomsAndSetPath("room_outside", path_outsideLow, 0.001);
		}
		CreateFader(FadeState.FadeOut, 0.01, fadeEndCallback);
	}
}