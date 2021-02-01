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


// Hacky, but let's try it anyway. Play the animation based on the speed of the player
// to avoid moonwalking
// < 0 = walking left, > 0 = walking right, and 0 = idle

// Only change walking animations if the player is in control, or it's automatically walking
if(GetControlState() == PlayerControlState.PlayerControl || path_speed != 0.0)
{
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
		sprite_index = anim_mimiWalk;
	}
	else if(m_movementState = MimiMovementState.Idle)
	{
		sprite_index = sprite_mimiIdle;
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
		SetMirrored(true);
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