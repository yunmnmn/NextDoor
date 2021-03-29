// Inherit the parent event
event_inherited();

// Depending on the game state, set the starting transition already
if(GetGlobalGameState() < GlobalGameStates.MimiRoomSits2)
{
	sprite_index = background_hallwayUpDay;
}
else
{
	sprite_index = background_hallwayUpNight;
}

// Play the music
if(GetGlobalGameState() <= GlobalGameStates.MimiWalksBackToRoom)
{
	// Play the new room music
	PlayRoomMusicAt(music_metalHallway, "Metal", true, 200, 230, 400, 2000, 1, true, 1);
	// Set the volume
	SoundGain(GetRoomMusic(), 0.6, 0.1);
}