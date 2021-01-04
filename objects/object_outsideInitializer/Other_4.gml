// Set Mimi on the path
PlayerSetPath(path_outsideLow, 0.0);

// Set the lower path callback, so Mimi can go up
var pathLowCallback = function()
{
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
	var playerHighEndCallback = function()
	{
		PlayerSetPath(path_outsideLow, 0.999);
	}
	PlayerSetPathEndCallback(playerHighEndCallback);
}
PlayerAddPathCallback(path_outsideHigh, 0.990, pathHighCallback, true);