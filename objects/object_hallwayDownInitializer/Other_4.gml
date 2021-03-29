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

if(GetGlobalGameState() <= GlobalGameStates.MimiWalksBackToRoom)
{
	// Play the new room music
	PlayRoomMusicAt(music_metalMimiRoom, "Metal", true, 200, 0, 400, 2000, 1, true, 1);
	// Set the volume
	SoundGain(GetRoomMusic(), 0.3, 0.1);
}
else if(GetGlobalGameState() >= GlobalGameStates.MimiReturnsFromDrinking)
{
	// Play the ambient sound
	PlayRoomMusic(music_ambient, "Ambient", true, 1.0, true);
	// Set the volume
	SoundGain(GetRoomMusic(), 1.0, 0.1);
}