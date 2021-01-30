// Set the position on the path
path_positionprevious = path_position; 
path_position = m_position;

function PathTypeCheck(p_callbackType, p_position)
{
	if(p_callbackType == PathCallbackType.LowToHigh)
	{
		if(path_positionprevious <= p_position && path_position >= p_position)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	else if(p_callbackType == PathCallbackType.HighToLow)
	{
		if(path_positionprevious >= p_position && path_position <= p_position)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	else
	{
		if((path_positionprevious < p_position && path_position > p_position) ||
			(path_positionprevious > p_position && path_positionprevious < p_position))
		{
			return true;
		}
		else
		{
			return false;
		}
	}
}

// Check if the there are registered path callbacks
for(i = 0; i < ds_list_size(m_pathCallbacks); /*don't iuncrement here*/)
{
	var pathCallback = ds_list_find_value(m_pathCallbacks, i);
	
	if(pathCallback.m_callback != noone && path_index == pathCallback.m_pathIndex && 
		PathTypeCheck(pathCallback.m_callbackType, pathCallback.m_position))
	{
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

