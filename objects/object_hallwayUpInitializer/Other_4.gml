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
	PlayRoomMusicAt(music_metalHallway, "Metal", true, 200, 230, 70, 2000, 1.5, true, 1);
	// Set the volume
	SoundGain(GetRoomMusic(), 0.6, 0.1);
}
else if(GetGlobalGameState() >= GlobalGameStates.MimiReturnsFromDrinking)
{
	// Play the ambient sound
	PlayRoomMusic(music_ambientScary, "AmbientScary", true, 1.0, true);
	// Set the volume
	SoundGain(GetRoomMusic(), 1.0, 0.1);
}