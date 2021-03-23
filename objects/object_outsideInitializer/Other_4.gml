// Inherit the parent event
event_inherited();

instance_stairs.visible = false;

// Set the lower path callback, so Mimi can go up
var pathLowCallback = function()
{
	// Set the stairs visible
	instance_stairs.visible = true;
	
	// TODO: test this path set to 1.0
	PlayerSetPath(path_outsideHigh, 1.0);
}

if(GetGlobalGameState() != GlobalGameStates.MimiGetsDrink && GetGlobalGameState() != GlobalGameStates.MimiReturnsFromDrinking)
{
	PlayerSetPathEndCallback(path_outsideLow, pathLowCallback, true, PathCallbackType.LowToHigh);
}

// Set the lower path callback, so Mimi can go down
var pathHighCallback = function()
{
	// Set the stairs invisible
	instance_stairs.visible = false;		
	
	// TODO: test this path set to 1.0
	PlayerSetPath(path_outsideLow, 1.0);
}
if(GetGlobalGameState() != GlobalGameStates.MimiGetsDrink && GetGlobalGameState() != GlobalGameStates.MimiReturnsFromDrinking)
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


// Depending on the game state, set the starting transition already
if(GetGlobalGameState() < GlobalGameStates.MimiRoomSits2)
{
	sprite_index = background_outsideDay;
}
else
{
	sprite_index = background_outside;
	
	// Enable the light at the door
	instance_outsideMemory.SetLampOutsideNearDoorVisible(true);
	// Play the flicking of the light
	PlayTimeline(timeline_flickeringLightDoor);
}

StopFlickering = function()
{
	StopTimeline();
}