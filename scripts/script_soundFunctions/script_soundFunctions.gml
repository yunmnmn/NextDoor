function PlaySound(p_soundIndex, p_priority, p_loop)
{
	assert(p_soundIndex != noone, "Sound is invalid");
	audio_play_sound(p_soundIndex, p_priority, p_loop);
}


function PlaySoundAt(p_soundIndex, p_x, p_y, p_falloffRef, p_falloffMax, p_falloffFactor, p_loop, p_priority)
{
	assert(p_soundIndex != noone, "Sound is invalid");
	audio_play_sound_at(p_soundIndex, p_x, p_y, 0, p_falloffRef, p_falloffMax, p_falloffFactor, p_loop, p_priority);
}

function StopSound(p_soundIndex)
{
	audio_stop_sound(p_soundIndex);
}

function SoundGain(p_soundIndex, p_volume, p_time)
{
	assert(p_soundIndex != noone, "Sound is invalid");
	audio_sound_gain(p_soundIndex, p_volume, p_time);
}

function GetSoundPosition(p_soundIndex)
{
	return audio_sound_get_track_position(p_soundIndex);
}

function SetSoundPosition(p_soundIndex, p_time)
{
	audio_sound_set_track_position(p_soundIndex, p_time);
}