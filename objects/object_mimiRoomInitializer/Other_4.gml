// Inherit the parent event
event_inherited();

if(GetGlobalGameState() < GlobalGameStates.MimiRoomSits2)
{
	sprite_index = background_mimiRoomDay;
}
else
{
	sprite_index = background_mimiRoomNight;
}