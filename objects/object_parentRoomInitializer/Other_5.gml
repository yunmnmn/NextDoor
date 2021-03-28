if(m_followPosition != noone)
{
	delete m_followPosition;
	m_followPosition = noone;
}

if(m_fromPosition = noone)
{
	delete m_fromPosition;
	m_fromPosition = noone;
}

if(m_viewportHalfSize != noone)
{
	delete m_viewportHalfSize;
	m_viewportHalfSize = noone;
}

ds_list_destroy(m_viewportCallbacks);

if(m_roomMusic != noone)
{
	m_roomMusicPosition = GetSoundPosition(m_roomMusic);
	StopSound(m_roomMusic);
	m_roomMusic = noone;
}