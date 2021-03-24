// HACK: Wait a few frames for the game to warm-up, and get the average deltatime
m_currentFrame++;
if(m_currentFrame > m_warmupFrames && !m_dirty)
{
	m_dirty = true;
	PlayTimeline(timeline_intro);
}