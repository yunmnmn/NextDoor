// Inherit the parent event
event_inherited();

// Depending on the game state, set the starting transition already
if(GetGlobalGameState() < GlobalGameStates.MimiRoomSits2)
{
	sprite_index = background_hallwayDownDay;
}
else
{
	sprite_index = background_hallwayDownNight;
}

