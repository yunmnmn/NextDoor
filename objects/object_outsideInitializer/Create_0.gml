// Set the lower path callback, so Mimi can go up
var pathLowCallback = function()
{
	// Set the new path end callback (going back to the first floor)
	var playerLowEndCallback = function()
	{
		PlayerSetPath(path_outsideHigh, 0.999);
	}
	PlayerSetPathEndCallback(playerLowEndCallback);
	
	// Set the new path start callback (going to the hallwayDown room)
	var pathStartCallback = function()
	{
		// Don't give the control to the player while transitioning
		SetControlState(PlayerControlState.PlayerNoControl);
	
		// Fade, and when finished, load the hallway
		var fadeEndCallback = function()
		{
			SetControlState(PlayerControlState.PlayerControl);
			ChangeRoomsAndSetPath("room_hallwayDown", path_hallwayDown, 0.999);
		}
		CreateFader(FadeState.FadeOut, 0.01, fadeEndCallback);
	}
	PlayerSetPathStartCallback(pathStartCallback);
	
}
PlayerAddPathCallback(path_outsideLow, 0.990, pathLowCallback, true);


// Set the lower path callback, so Mimi can go down
var pathHighCallback = function()
{
	// Set the new path end callback (going back to the second floor)
	var playerHighEndCallback = function()
	{
		PlayerSetPath(path_outsideLow, 0.999);
	}
	PlayerSetPathEndCallback(playerHighEndCallback);
	
	// Set the new path start callback (going to the hallwayUp room)
	var pathStartCallback = function()
	{
		// Don't give the control to the player while transitioning
		SetControlState(PlayerControlState.PlayerNoControl);
	
		// Fade, and when finished, load the hallway
		var fadeEndCallback = function()
		{
			SetControlState(PlayerControlState.PlayerControl);
			ChangeRoomsAndSetPath("room_hallwayUp", path_hallwayUp, 0.999);
		}
		CreateFader(FadeState.FadeOut, 0.01, fadeEndCallback);
	}
	PlayerSetPathStartCallback(pathStartCallback);
	
}
PlayerAddPathCallback(path_outsideHigh, 0.990, pathHighCallback, true);