// Call the callback function if it's not noone
if(m_callbackAnimationEnd != noone)
{
	var cacheCallback = m_callbackAnimationEnd;
	m_callbackAnimationEnd = noone;
	cacheCallback();
}