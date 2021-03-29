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

if(GetGlobalGameState() <= GlobalGameStates.MimiGoingToYoungster)
{
	m_roomMusic = PlaySoundAt(music_metalMimiRoom, 200, 0, 400, 2000, 1, true, 1);
	SoundGain(m_roomMusic, 0.3, 0.1);
}

// Call the PostRoomLoad function, might be set from other systems (e.g ChangeRoomAndSetPath())
ExecutePostRoomLoadCallbacks(id);