var callback = function()
{
	ChangeRooms("room_test2");
}

// Fade, and when finished, load the hall
CreateFader(FadeState.FadeOut, 0.01, callback);

// Don't give the control to the player at the beginning
SetControlState(PlayerControlState.PlayerNoControl);