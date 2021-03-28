// Remove the pressing button prompt
instance_global.DrawActionPressPrompt(false, 0, 0);
// Remove the moving button prompt
instance_global.DrawMovingPrompt(false, 0, 0);

var postRoomLoadCallback = function(p_roomInstance)
{
	if(m_roomMusic != noone)
	{
		// Get sound position
		var soundPosition = GetSoundPosition(m_roomMusic);
		// Stop playing the music
		StopSound(m_roomMusic);
	
		//p_roomInstance.m_roomMusic = PlaySoundAt(music_metalMimiRoom, 200, 0, 1, 0, 10, true, 1);
		//SetSoundPosition(p_roomInstance.m_roomMusic, soundPosition);
	}
}
AddPostRoomLoadCallback(postRoomLoadCallback);

