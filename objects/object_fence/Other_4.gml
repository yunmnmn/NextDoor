// Depending on the game state, set the starting transition already
if(GetGlobalGameState() < GlobalGameStates.MimiRoomSits2)
{
	sprite_index = foreground_fenceDay;
}
else
{
	sprite_index = foreground_fence;
}