m_stairs = instance_find(object_stairs, 0);
m_stairs.visible = false;

// Set the lower path callback, so Mimi can go up
var pathLowCallback = function()
{
	var playerLowEndCallback = function()
	{
		// Set the stairs visible
		m_stairs.visible = true;
	
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
		// Set the stairs invisible
		m_stairs.visible = false;
		
		PlayerSetPath(path_outsideLow, 0.999);
	}
	PlayerSetPathEndCallback(playerHighEndCallback);
}
PlayerAddPathCallback(path_outsideHigh, 0.990, pathHighCallback, true);

// Set a callback to make the stairs visible if mimi is nearing it
var pathHighStairsVisibleCallback = function()
{
	// Set the stairs visible
	m_stairs.visible = true;
}
PlayerAddPathCallback(path_outsideHigh, 0.5, pathHighStairsVisibleCallback, true);