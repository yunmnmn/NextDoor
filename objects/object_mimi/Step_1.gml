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
for(i = 0; i < ds_list_size(m_pathCallbacks); /*don't iuncrement here*/)
{
	var pathCallback = ds_list_find_value(m_pathCallbacks, i);
	
	if(pathCallback.m_callback != noone && path_index == pathCallback.m_pathIndex &&
	((pathCallback.m_position < path_positionprevious && pathCallback.m_position > path_position) || 
	(pathCallback.m_position < path_position && pathCallback.m_position > path_positionprevious)))
	{
		var tempCallback = pathCallback.m_callback;
		pathCallback.m_callback();
		
		// Remove the callback if it's not persistant. Add i when something isn't removed
		if(!pathCallback.m_persistant)
		{
			ds_list_delete(m_pathCallbacks, i);
		}
		else
		{
			i++;
		}
	}
	else
	{
		i++;
	}
}

