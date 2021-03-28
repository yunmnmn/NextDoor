function PlaySound(p_soundIndex, p_priority, p_loop)
{
	assert(p_soundIndex != noone, "Sound is invalid");
	return audio_play_sound(p_soundIndex, p_priority, p_loop);
}

function PlaySoundAt(p_soundIndex, p_x, p_y, p_falloffRef, p_falloffMax, p_falloffFactor, p_loop, p_priority)
{
	assert(p_soundIndex != noone, "Sound is invalid");
	return audio_play_sound_at(p_soundIndex, p_x, p_y, 0, p_falloffRef, p_falloffMax, p_falloffFactor, p_loop, p_priority);
}

function StopSound(p_soundInstance)
{
	audio_stop_sound(p_soundInstance);
}

function SoundGain(p_soundInstance, p_volume, p_time)
{
	assert(p_soundInstance != noone, "Sound is invalid");
	audio_sound_gain(p_soundInstance, p_volume, p_time);
}

function GetSoundPosition(p_soundInstance)
{
	return audio_sound_get_track_position(p_soundInstance);
}

function SetSoundPosition(p_soundInstance, p_time)
{
	audio_sound_set_track_position(p_soundInstance, p_time);
}

function SetAudioListenerPosition(p_x, p_y)
{
	audio_listener_position(p_x, p_y, 0);
	audio_listener_orientation(0, 0, 1, 0, -1, 0);
}