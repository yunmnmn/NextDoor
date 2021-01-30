// Check if the there are registered path callbacks
for(i = 0; i < ds_list_size(m_pathCallbacks); /*don't iuncrement here*/)
{
	// HACK: when the path ends, it automatically invalids the path_index, and resets everything...
	if(path_index == -1)
	{
		var prevPosTemp = path_positionprevious;
		var curPosTemp = path_position;
		
		path_start(m_pathIndex, 0.0, path_action_stop, true);
		path_positionprevious = prevPosTemp;
		path_position = curPosTemp;
	}
	
	var pathCallback = ds_list_find_value(m_pathCallbacks, i);
	
	var belowToUp = path_positionprevious <= pathCallback.m_position && path_position >= pathCallback.m_position;
	var upToBelow = path_positionprevious >= pathCallback.m_position && path_positionprevious <= pathCallback.m_position;
	if(pathCallback.m_callback != noone && path_index == pathCallback.m_pathIndex &&
		(belowToUp || upToBelow))
	{
		pathCallback.m_callback();
		pathCallback.m_dirty = true;
		
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
