// If the playe ris not in control, let the build in variables set the custom variables
if(GetControlState() == PlayerControlState.PlayerNoControl)
{
	 m_position = path_position;
	 m_cachedPosition = path_positionprevious;
}

function PathTypeCheck(p_callbackType, p_position)
{
	if(p_callbackType == PathCallbackType.LowToHigh)
	{
		if(m_cachedPosition <= p_position && m_position >= p_position)
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
		if(m_cachedPosition >= p_position && m_position <= p_position)
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
		if((m_cachedPosition <= p_position && m_position >= p_position) ||
			(m_cachedPosition >= p_position && m_position <= p_position))
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


// Hacky, but let's try it anyway. Play the animation based on the speed of the player
// to avoid moonwalking
// < 0 = walking left, > 0 = walking right, and 0 = idle

// Only change walking animations if the player is in control, or it's automatically walking
if(GetControlState() == PlayerControlState.PlayerControl || path_speed != 0.0)
{
	// If the player is in control, always set the image_speed to default
	image_speed = 1.0;
	
	// Set the states first depending on the cached states from the previous frame
	var delta = 0.000001;
	if(abs(m_cachedPosition - m_position) > delta)
	{
		m_movementState = MimiMovementState.Walking;
	}
	else
	{
		m_movementState = MimiMovementState.Idle
	}

	if(m_cachedPosition > m_position)
	{
		m_direction = Direction.Left;
	}
	else if(m_cachedPosition < m_position)
	{
		m_direction = Direction.Right;
	}

	// Set the animation depending on the movement state
	if(m_movementState == MimiMovementState.Walking)
	{
		if(GetMimiCrawling())
		{
			sprite_index = anim_mimiCrawl;
		}
		else if(GetMimiScared())
		{
			sprite_index = anim_mimiWalkScared;
		}
		else
		{
			sprite_index = anim_mimiWalk;
		}
	}
	else if(m_movementState = MimiMovementState.Idle)
	{
		if(GetMimiCrawling())
		{
			sprite_index = anim_mimiCrawlIdle;
		}
		else if(GetMimiScared())
		{
			sprite_index = sprite_mimiIdleScared;
		}
		else
		{
			sprite_index = sprite_mimiIdle;
		}
	}
	else
	{
		assert(false, "Movement state can't be default");
	}

	// Set the looking direction depending if it's mirrored
	if(m_direction == Direction.Right)
	{
		SetMirrored(false);
	}
	else if(m_direction == Direction.Left)
	{
		if(GetMimiCrawling())
		{
			SetMirrored(false);
		}
		else
		{
			SetMirrored(true);
		}
	}
	else
	{
		assert(false, "Direction has to be Right or Left");
	}

	// Set the cached states
	m_cachedPosition = m_position;
	m_cachedDirection = m_direction;
	m_cachedMovementState = m_movementState;
}
else
{
	m_cachedPosition = m_position;
	m_cachedDirection = m_direction;
	m_cachedMovementState = m_movementState;
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
			if(soundContext.m_listener == noone)
			{
				PlaySound(soundIndex, soundContext.m_priority, soundContext.m_loop);
			}
			else
			{
				// TODO: play with listener and position
			}
		}
		
		// Set the dirty flag to true, so the context knows it's already been played
		soundContext.m_dirty = true;
		
		// Delete it if the SoundContext isn't persistent
		if(!soundContext.m_persistent)
		{
			delete soundContext;
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