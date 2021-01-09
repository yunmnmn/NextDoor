// Transition the room when Mimi reaches the start of the hallway
var pathStartCallback = function()
{
	// Don't give the control to the player while transitioning
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Fade, and when finished, load the hallway
	{
		var fadeEndCallback = function()
		{
			SetControlState(PlayerControlState.PlayerControl);
			ChangeRoomsAndSetPath("room_mimiRoom", path_mimiRoom, 0.999);
		}
		CreateFader(FadeState.FadeOut, 0.01, fadeEndCallback);
	}
}
PlayerSetPathStartCallback(pathStartCallback);

// Transition the room when Mimi reaches the end of the hallway (to outside, first floor)
var pathEndCallback = function()
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
PlayerSetPathEndCallback(pathEndCallback);