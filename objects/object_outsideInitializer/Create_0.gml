// Set the lower path callback, so Mimi can go up
var pathLowCallback = function()
{
	// Set the new path end callback (going back to the first floor)
	var playerLowEndCallback = function()
	{
		PlayerSetPath(path_outsideHigh, 0.999);
	}
	PlayerSetPathEndCallback(playerLowEndCallback);
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
}
PlayerAddPathCallback(path_outsideHigh, 0.990, pathHighCallback, true);