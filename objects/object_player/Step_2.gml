// Hacky, but let's try it anyway. Play the animation based on the speed of the player
// to avoid moonwalking
// < 0 = walking left, > 0 = walking right, and 0 = idle

// Set the states first depending on the cached states from the previous frame
if(m_cachedPosition != m_position)
{
	m_movementState = MimiMovementState.Walking;
}
else
{
	m_movementState = MimiMovementState.Idle
}

if(m_cachedPosition > m_position)
{
	m_direction = MimiDirection.Left;
}
else if(m_cachedPosition < m_position)
{
	m_direction = MimiDirection.Right;
}

// Set the animations depending on the states from previous to now
if(m_movementState != m_cachedMovementState)
{
	if(m_movementState == MimiMovementState.Walking)
	{
		sprite_index = sprite_anim_mimi_walk_right;
	}
	else if(m_movementState = MimiMovementState.Idle)
	{
		sprite_index = sprite_mimi_idle_right;
	}
	else
	{
		// Don't handle default for now
	}
}

if(m_direction != m_cachedDirection)
{
	if(m_direction == MimiDirection.Right)
	{
		image_xscale = 1.0;
	}
	else if(m_direction == MimiDirection.Left)
	{
		image_xscale = -1.0;
	}
	else
	{
		// Don't handle default case for now
	}
}

// Set the cached states
m_cachedPosition = m_position;
m_cachedDirection = m_direction;
m_cachedMovementState = m_movementState;