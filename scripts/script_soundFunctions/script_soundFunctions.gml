function PlaySound(p_soundIndex, p_priority, p_loop)
{
	assert(p_soundIndex != noone, "Sound is invalid");
	audio_play_sound(p_soundIndex, p_priority, p_loop);
}