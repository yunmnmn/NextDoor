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
if(GetGlobalGameState() <= GlobalGameStates.MimiGoingToKnockAtNeighbour)
{
	m_roomMusic = PlaySoundAt(music_metalHallway, 200, 230, 400, 2000, 1, true, 1);
	SoundGain(m_roomMusic, 0.6, 0.1);
}

// Call the PostRoomLoad function, might be set from other systems (e.g ChangeRoomAndSetPath())
ExecutePostRoomLoadCallbacks(id);