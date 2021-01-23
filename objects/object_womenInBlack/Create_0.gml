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

function SetPath(p_pathIndex, p_position, p_speed)
{
	path_start(p_pathIndex, p_speed, path_action_stop, true);
	path_position = p_position;
}

function PlayAnimation(p_spriteIndex)
{
	sprite_index = p_spriteIndex;
}

function Mirror()
{
	image_xscale = -1.0;
}

function SetPathEndCallback(p_callback)
{
	m_callbackPathEnd = p_callback;
}

m_callbackPathEnd = noone;
m_speed = 1.3;