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

function SetPath(p_pathIndex, p_position)
{
	var tempX = x;
	var tempY = y;
	m_path = p_pathIndex;
	path_start(p_pathIndex, 0, path_action_reverse, true);
	m_position = p_position;
	path_position = p_position;
	path_positionprevious = p_position;
	
	// HACK: This is here because path_start actually moves the object in the function
	x = tempX;
	y = tempY;
}

function GetPath()
{
	return m_path;
}

function SetPathEndCallback(p_pathEndCallback)
{
	m_callbackPathEnd = p_pathEndCallback;
}

function AddPathCallback(p_pathCallback)
{
	ds_list_add(m_pathCallbacks, p_pathCallback);
}

function SetSpeed(p_speed)
{
	m_speed = p_speed;
}

// Calcultes the movement depending on the path's length and the speed
// TODO: add delta time
function GetMovementSpeed()
{
	var pathLength = path_get_length(m_path);
	return (1.0 / pathLength) * m_speed;
}

function PlayAnimation(p_spriteIndex, p_callbackEnd)
{
	sprite_index = p_spriteIndex;
	m_callbackAnimationEnd = p_callbackEnd;
}

// Register mimi to the global object
RegisterPlayerInstance(id);

// By default, set Mimi into a idle sprite
PlayAnimation(sprite_mimiIdle, noone);

// These variables are set by the instance manager
m_speed = 4.0; // TODO: original 2
m_position = 0.0;
m_path = noone;

// Path callbacks
m_callbackAnimationEnd = noone;
m_callbackPathEnd = noone;

m_pathCallbacks = ds_list_create();

// These variables are set by the player object itself
m_direction = MimiDirection.Right;
m_movementState = MimiMovementState.Idle;

// Cached position is used to determine the animation to play
m_cachedPosition = m_position;
m_cachedDirection = m_direction;
m_cachedMovementState = m_movementState;