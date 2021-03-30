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
			(path_positionprevious > p_position && path_position < p_position))
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
for(var i = 0; i < ds_list_size(m_pathCallbacks); /*don't iuncrement here*/)
{
	// HACK: when the path ends, it automatically invalidates the path_index, and resets everything...
	if(path_index == -1)
	{
		var prevPosTemp = path_positionprevious;
		var curPosTemp = path_position;
		
		path_start(m_pathIndex, 0.0, path_action_stop, true);
		path_positionprevious = prevPosTemp;
		path_position = curPosTemp;
	}
	
	var pathCallback = ds_list_find_value(m_pathCallbacks, i);
	
	if(pathCallback.m_callback != noone && path_index == pathCallback.m_pathIndex &&
		PathTypeCheck(pathCallback.m_callbackType, pathCallback.m_position))
	{
		pathCallback.m_callback();
		
		// Remove the callback if it's not persistant. Add i when something isn't removed
		if(!pathCallback.m_persistant)
		{
			delete pathCallback;
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

// Play sounds here
// HACK: Avoid playing sounds multiple times in the same image_index
if(m_cachedFlooredImageIndex != floor(image_index))
{
	m_cachedFlooredImageIndex = floor(image_index);
	
	// Reset all the sound contexts
	for(var i = 0; i < ds_list_size(m_soundContexts); i++)
	{
		var soundContext = ds_list_find_value(m_soundContexts, i);
		soundContext.m_dirty = false;
	}
}

// Iterate through all SoundContexts and see if something needs to be played
for(var i = 0; i < ds_list_size(m_soundContexts);  /*don't iuncrement here*/)
{
	var soundContext = ds_list_find_value(m_soundContexts, i);
	assert(soundContext != noone, "SoundContext in array is invalid");
	
	if(	sprite_index == soundContext.m_spriteIndex &&
		m_cachedFlooredImageIndex == soundContext.m_imageIndex)
	{
		if(soundContext.m_playPredicate() && !soundContext.m_dirty)
		{
			var soundIndex = soundContext.m_soundPredicate();
			
			// Doesn't have a listener, so play it in general
			if(soundContext.m_positionX == noone && soundContext.m_positionY == noone && soundContext.m_playSoundFromInstance == false)
			{
				PlaySound(soundIndex, soundContext.m_priority, soundContext.m_loop);
			}
			else
			{
				var posX = 0.0;
				var posY = 0.0;
				if(soundContext.m_playSoundFromInstance)
				{
					posX = x;
					posY = y;
				}
				else if(soundContext.m_positionX != noone && soundContext.m_positionY != noone)
				{
					posX = soundContext.m_positionX;
					posY = soundContext.m_positionY;
				}
				else
				{
					assert(false, "SoundContext can't play SoundAt");
				}
				
				PlaySoundAt(soundIndex, posX, posY, 20, 2000, 2.2, soundContext.m_loop, soundContext.m_priority);
			}
		}
		
		// Set the dirty flag to true, so the context knows it's already been played
		soundContext.m_dirty = true;
		
		// Delete it if the SoundContext isn't persistent
		if(!soundContext.m_persistent)
		{
			delete soundContext;
			ds_list_delete(m_soundContexts, i);
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
