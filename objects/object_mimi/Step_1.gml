// Clamp the positions between 0-1
m_position = clamp(m_position, 0.0, 1.0);

// Set the position on the path
path_positionprevious = path_position; 
path_position = m_position;

// Check if the start callback is met
if(m_callbackPathStart != noone && m_position == 0.0)
{
	var tempCallback = m_callbackPathStart;
	m_callbackPathStart();
	
	// If the callbacks are the same, set it to noone, else leave it alone (meaning it got changed by the callback)
	if(tempCallback == m_callbackPathStart)
	{
		m_callbackPathStart = noone;	
	}
}

// Check if the end callback is met
if(m_callbackPathEnd != noone && m_position == 1.0)
{
	var tempCallback = m_callbackPathEnd;
	m_callbackPathEnd();
	
	// If the callbacks are the same, set it to noone, else leave it alone (meaning it got changed by the callback)
	if(tempCallback == m_callbackPathEnd)
	{
		m_callbackPathEnd = noone;	
	}
}

// Check if the there are registered path callbacks
var pathCallbackCount = ds_list_size(m_pathCallbacks);
for(i = 0; i < pathCallbackCount; i++)
{
	var pathCallback = ds_list_find_value(m_pathCallbacks, i);
	
	if(pathCallback.m_callback != noone && path_index == pathCallback.m_pathIndex &&
	((pathCallback.m_position < path_positionprevious && pathCallback.m_position > path_position) || 
	(pathCallback.m_position < path_position && pathCallback.m_position > path_positionprevious)))
	{
		var tempCallback = pathCallback.m_callback;
		pathCallback.m_callback();
		
		if(!pathCallback.m_persistant)
		{
			// TODO: remove from list
		}
	}
}

