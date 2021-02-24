// Inherit the parent event
event_inherited();

instance_stairs.visible = false;

// Set the lower path callback, so Mimi can go up
var pathLowCallback = function()
{
	// Set the stairs visible
	instance_stairs.visible = true;
	
	PlayerSetPath(path_outsideHigh, 0.9999)
}

if(GetGlobalGameState() != GlobalGameStates.MimiGetsDrink)
{
	PlayerSetPathEndCallback(path_outsideLow, pathLowCallback, true, PathCallbackType.LowToHigh);
}


// Set the lower path callback, so Mimi can go down
var pathHighCallback = function()
{
	// Set the stairs invisible
	instance_stairs.visible = false;		
	
	PlayerSetPath(path_outsideLow, 0.9999)
}
if(GetGlobalGameState() != GlobalGameStates.MimiGetsDrink)
{
	PlayerSetPathEndCallback(path_outsideHigh, pathHighCallback, true, PathCallbackType.LowToHigh);
}


// Set a callback to make the stairs visible if mimi is nearing it
var pathHighStairsVisibleCallback = function()
{
	// Set the stairs visible
	instance_stairs.visible = true;
}
if(GetGlobalGameState() != GlobalGameStates.MimiGetsDrink)
{
	PlayerAddPathCallback(path_outsideHigh, 0.5, pathHighStairsVisibleCallback, true, PathCallbackType.Both);
}