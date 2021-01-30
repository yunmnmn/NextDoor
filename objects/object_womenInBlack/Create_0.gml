function SetPath(p_pathIndex, p_position, p_speed)
{
	assert(((p_position >= 0.0) && (p_position <= 1.0)), "Position out of range");
		
	m_pathIndex = p_pathIndex;
	m_speed = p_speed;
	
	path_start(m_pathIndex, p_speed, path_action_stop, true);
}

function PlayAnimation(p_spriteIndex)
{
	sprite_index = p_spriteIndex;
}

function AddPathPointCallback(p_pathPoint, p_callback, p_persistant)
{
	assert(m_pathIndex != noone, "PathIndex is invalid");
	
	var pathPosition = SnapToClosestPathIndex(m_pathIndex, p_pathPoint);
	var pathCallback = new PathCallback(m_pathIndex, pathPosition, p_callback, p_persistant, PathCallbackType.Both);
	ds_list_add(m_pathCallbacks, pathCallback);
}

function AddPathEndCallback(p_callback, p_persistant)
{
	AddPathPointCallback(path_get_number(m_pathIndex)-1, p_callback, p_persistant);
}

function AddPathBeginCallback(p_callback, p_persistant)
{
	AddPathPointCallback(0, p_callback, p_persistant);
}

m_pathIndex = noone;
m_speed = 1.3;

m_pathCallbacks = ds_list_create();