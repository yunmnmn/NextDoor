function PlaySound(p_soundIndex, p_priority, p_loop)
{
	assert(p_soundIndex != noone, "Sound is invalid");
	//if(audio_system_is_available())
	{
		return audio_play_sound(p_soundIndex, p_priority, p_loop);
	}
}

function PlaySoundAt(p_soundIndex, p_x, p_y, p_falloffRef, p_falloffMax, p_falloffFactor, p_loop, p_priority)
{
	assert(p_soundIndex != noone, "Sound is invalid");
	//if(audio_system_is_available())
	{
		return audio_play_sound_at(p_soundIndex, p_x, p_y, 0, p_falloffRef, p_falloffMax, p_falloffFactor, p_loop, p_priority);
	}
}

function StopSound(p_soundInstance)
{
	assert(p_soundInstance != noone, "Sound instance is invalid");
	//if(audio_system_is_available())
	{
		audio_stop_sound(p_soundInstance);
	}
}

function SoundGain(p_soundInstance, p_volume, p_time)
{
	assert(p_soundInstance != noone, "Sound instance is invalid");
	//if(audio_system_is_available())
	{
		audio_sound_gain(p_soundInstance, p_volume, p_time);
	}
}

function GetSoundPosition(p_soundInstance)
{
	assert(p_soundInstance != noone, "Sound instance is invalid");
	return audio_sound_get_track_position(p_soundInstance);
}

function SetSoundPosition(p_soundInstance, p_time)
{
	assert(p_soundInstance != noone, "Sound instance is invalid");
	audio_sound_set_track_position(p_soundInstance, p_time);
}

function SetAudioListenerPosition(p_x, p_y)
{
	audio_listener_position(p_x, p_y, 0);
	audio_listener_orientation(0, 0, 1, 0, -1, 0);
}

function FindSoundGroup(p_soundGroupName)
{
	for(var i = 0; i < ds_list_size(global.m_soundGroups); i++)
	{
		var soundGroup = ds_list_find_value(global.m_soundGroups, i);
		if(p_soundGroupName == soundGroup.m_soundGroupName)
		{
			return soundGroup;
		}
	}
	
	return noone;
}

function RegisterSoundGroupFromMusic(p_soundGroupName, p_soundInstance)
{
	assert(p_soundInstance != noone, "Sound instance is invalid");
	
	var soundPosition = GetSoundPosition(p_soundInstance);
	RegisterSoundGroup(p_soundGroupName, soundPosition);
}

function RegisterSoundGroup(p_soundGroupName, p_soundPosition)
{
	var soundGroup = FindSoundGroup(p_soundGroupName);
	
	if(soundGroup == noone)
	{
		soundGroup = new SoundGroup(p_soundGroupName);
		ds_list_add(global.m_soundGroups, soundGroup);
	}
	
	soundGroup.SetSoundPosition(p_soundPosition);
}

function GetSoundGroupPosition(p_soundGroupName)
{
	var soundGroup = FindSoundGroup(p_soundGroupName);
	if(soundGroup == noone)
	{
		return 0.0;
	}
	
	return soundGroup.GetSoundPosition();
}

function GetRoomMusic()
{
	return GetBackgroundInstance().m_roomMusic;
}

function GetRoomMusicGroup()
{
	return GetBackgroundInstance().m_roomMusicGroup;
}

//function GetRoomMusicPosition()
//{
//	return GetBackgroundInstance().m_roomMusicPosition;
//}

function PlayRoomMusic(p_soundIndex, p_soundGroupName, p_getSoundPositionFromGroup, p_priority, p_loop)
{
	assert(p_soundIndex != noone, "Sound is invalid");
	GetBackgroundInstance().PlayMusic(p_soundIndex, p_soundGroupName, p_getSoundPositionFromGroup, p_priority, p_loop);
}

function PlayRoomMusicAt(p_soundIndex, p_soundGroupName, p_getSoundPositionFromGroup, p_x, p_y, p_falloffRef, p_falloffMax, p_falloffFactor, p_loop, p_priority)
{
	assert(p_soundIndex != noone, "Sound is invalid");
	GetBackgroundInstance().PlayMusicAt(p_soundIndex, p_soundGroupName, p_getSoundPositionFromGroup, p_x, p_y, p_falloffRef, p_falloffMax, p_falloffFactor, p_loop, p_priority);
}

function StopRoomMusic()
{
	GetBackgroundInstance().StopMusic();
}