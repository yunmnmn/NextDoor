// Play the movie sound on frame 9
if(floor(m_drawFrame) == 9 && m_movieSoundDirty == false)
{
	m_movieSoundDirty = true;
	
	// Play the movie sound
	PlaySound(foley_movieSound, 10.0, false);
}