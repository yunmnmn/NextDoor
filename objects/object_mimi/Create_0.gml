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

function AddPathCallback(p_pathCallback)
{
	// Before adding it to the callback list, check if the conditions are met already
	var delta = GetPathDistanceFromPixels(p_pathCallback.m_pathIndex, 6);
	if(p_pathCallback.m_callback != noone)
	{
		var withinDelta = abs(p_pathCallback.m_position - m_position) < delta;
		if(withinDelta)
		{
			p_pathCallback.m_callback();
			// Still add it to the list if it's persistant
			if(p_pathCallback.m_persistant)
			{
				ds_list_add(m_pathCallbacks, p_pathCallback);
			}
		}
		else
		{
			// Else add it to the list
			ds_list_add(m_pathCallbacks, p_pathCallback);
		}
	}
}

// MOvement speed of mimi when the player controls it
// TODO: connect this to m_pathSpeed
function SetSpeed(p_speed)
{
	m_speed = p_speed;
}

// Path speed of the player when it's controlled by the path system
// Give it a multiplier instead. The eventual speed will be calculated from m_speed
function SetPathSpeed(p_pathSpeedMultiplier)
{
	m_pathSpeed = p_pathSpeedMultiplier * GetMovementSpeed() * path_get_length(m_path);
	path_speed = m_pathSpeed;
}

function SetMirrored(p_mirrored)
{
	if(p_mirrored)
	{
		image_xscale = -1.0;
		m_mirrored = true;
		
		// This only applies for the idle and walk animation
		m_direction = Direction.Left;
	}
	else
	{
		image_xscale = 1.0;
		m_mirrored = false;
		
		// This only applies for the idle and walk animation
		m_direction = Direction.Right;
	}
}

// Calcultes the movement depending on the path's length and the speed (normalized value between 0.0 - 1.0)
function GetMovementSpeed()
{
	var pathLength = path_get_length(m_path);
	return (1.0 / pathLength) * m_speed * DeltaTimeInMiliseconds();
}

function PlayAnimation(p_spriteIndex, p_callbackEnd)
{
	sprite_index = p_spriteIndex;
	image_index = 0;
	image_speed = 1;
	m_callbackAnimationEnd = p_callbackEnd;
}

function PlayAnimationBackwards(p_spriteIndex, p_callbackEnd)
{
	sprite_index = p_spriteIndex;
	image_index = sprite_get_number(p_spriteIndex) - 1;
	image_speed = -1;
	m_callbackAnimationEndBackwards = p_callbackEnd;
}

function MoveAndExecute(p_positionX, p_positionY, p_speed, p_callback)
{
	assert(m_path != noone, "Path can't be invalid");
	assert(GetControlState() == PlayerControlState.PlayerNoControl, "This function can only be called when the player is in NoControl state");
	
	// Set the path speed
	var pathPosition = SnapToClosestPosition(PlayerGetPath(), p_positionX, p_positionY);
	var moveDirection = (pathPosition > m_position) ? 1.0 : -1.0;
	var pathSpeed = p_speed * moveDirection;
	SetPathSpeed(pathSpeed);
	
	// Set the callback
	AddPathCallback(new PathCallback(m_path, pathPosition, p_callback, false, PathCallbackType.Both));
}

// Register mimi to the global object
RegisterPlayerInstance(id);

// By default, set Mimi into a idle sprite
PlayAnimation(sprite_mimiIdle, noone);

// These variables are set by the instance manager
if(DebugMode())
{
	SetSpeed(0.4);
}
else
{
	SetSpeed(0.15); 
}

m_position = 0.0;

m_path = noone;
m_pathSpeed = 0.0;

// Path callbacks
m_pathCallbacks = ds_list_create();

// This callback will be called when the animatino is finished
m_callbackAnimationEnd = noone;
m_callbackAnimationEndBackwards = noone;

// These variables are set by the player object itself
m_mirrored = false;
m_direction = Direction.Right;
m_movementState = MimiMovementState.Idle;

// Cached position is used to determine the animation to play
m_cachedPosition = m_position;
m_cachedDirection = m_direction;
m_cachedMovementState = m_movementState;