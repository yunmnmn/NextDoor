enum MimiDirection
{
	Right,
	Left
}

enum MimiMovementState
{
	Idle,
	Walking
}

// Set the default values for Mimi's movement
m_speed = 0.002;
m_position = 0.0;
m_direction = MimiDirection.Right;
m_movementState = MimiMovementState.Idle;

// Cached position is used to determine the animation to play
m_cachedPosition = m_position;
m_cachedDirection = m_direction;
m_cachedMovementState = m_movementState;

// Set Mimi on the path
path_start(path_test, 0, path_action_stop, true);

// HACK: Set a default animation to play
sprite_index = sprite_mimi_idle_right;

