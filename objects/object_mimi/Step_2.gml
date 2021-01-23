// Hacky, but let's try it anyway. Play the animation based on the speed of the player
// to avoid moonwalking
// < 0 = walking left, > 0 = walking right, and 0 = idle

// Only change walking animations if the player is in control
if(GetControlState() == PlayerControlState.PlayerControl)
{
	// Set the states first depending on the cached states from the previous frame
	var delta = 0.00001;
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

	// Set the animations depending on the states from previous to now
	if(m_movementState != m_cachedMovementState)
	{
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
			assert_fail(true, "Movement state can't be default");
		}
	}

	if(m_direction != m_cachedDirection)
	{
		if(m_direction == Direction.Right)
		{
			image_xscale = 1.0;
			m_mirrored = false;
		}
		else if(m_direction == Direction.Left)
		{
			image_xscale = -1.0;
			m_mirrored = true;
		}
		else
		{
			assert_fail(true, "Direction has to be Right or Left");
		}
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