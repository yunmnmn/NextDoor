// Check if the end callback is met
if(m_callbackPathEnd != noone && path_position >= 0.95)
{
	var tempCallback = m_callbackPathEnd;
	m_callbackPathEnd();
	
	// If the callbacks are the same, set it to noone, else leave it alone (meaning it got changed by the callback)
	if(tempCallback == m_callbackPathEnd)
	{
		m_callbackPathEnd = noone;	
	}
}