enum MimiMovementState
{
	Idle,
	Walking
}

enum Direction
{
	Left,
	Right
}

function SetPath(p_pathIndex, p_position)
{	
	assert(((p_position >= 0.0) && (p_position <= 1.0)), "Position out of range");
		
	var tempX = x;
	var tempY = y;
	m_path = p_pathIndex;
	path_start(p_pathIndex, 0, path_action_stop, true);
	m_position = p_position;
	m_cachedPosition = p_position;
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

function SetPathEndCallback(p_callback)
{
	m_callbackPathEnd = p_callback;
}

function SetPathStartCallback(p_callback)
{
	m_callbackPathStart = p_callback;
}

function AddPathCallback(p_pathCallback)
{
	ds_list_add(m_pathCallbacks, p_pathCallback);
}

function SetSpeed(p_speed)
{
	m_speed = p_speed;
}

function SetMirrored(p_mirrored)
{
	if(p_mirrored)
	{
		image_xscale = -1.0;
		m_mirrored = true;
	}
	else
	{
		image_xscale = 1.0;
		m_mirrored = false;
	}
}

// Calcultes the movement depending on the path's length and the speed
function GetMovementSpeed()
{
	var pathLength = path_get_length(m_path);
	return (1.0 / pathLength) * m_speed * DeltaTimeInMiliseconds();
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
SetSpeed(0.4); 
m_position = 0.0;
m_path = noone;

// Path callbacks
m_callbackAnimationEnd = noone;
m_callbackPathEnd = noone;
m_callbackPathStart = noone;

m_pathCallbacks = ds_list_create();

// These variables are set by the player object itself
m_mirrored = false;
m_direction = Direction.Right;
m_movementState = MimiMovementState.Idle;

// Cached position is used to determine the animation to play
m_cachedPosition = m_position;
m_cachedDirection = m_direction;
m_cachedMovementState = m_movementState;