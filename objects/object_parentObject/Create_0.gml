// Call the parent create(object_parentTrigger)
event_inherited();

// Set the instance on a path
function SetPath(p_pathIndex, p_position, p_speed)
{
	assert(((p_position >= 0.0) && (p_position <= 1.0)), "Position out of range");
		
	m_pathIndex = p_pathIndex;
	
	path_start(m_pathIndex, p_speed, path_action_stop, true);
}

// Play an animation on the instance
function PlayAnimation(p_spriteIndex, p_mirrored, p_callback)
{
	Mirror(p_mirrored);
	sprite_index = p_spriteIndex;
	image_speed = 1.0;
	image_index = 0;
	m_callbackAnimationEnd = p_callback;
}

// Play an animation on the instance
function PlayAnimation2(p_spriteIndex, p_callback)
{
	PlayAnimation(p_spriteIndex, m_mirrored, p_callback);
}

// Set a callback when the instance reaches the point
function AddPathPointCallback(p_pathPoint, p_callback, p_persistant)
{
	assert(m_pathIndex != noone, "PathIndex is invalid");
	
	var pathPosition = SnapToClosestPathIndex(m_pathIndex, p_pathPoint);
	var pathCallback = new PathCallback(m_pathIndex, pathPosition, p_callback, p_persistant, PathCallbackType.Both);
	ds_list_add(m_pathCallbacks, pathCallback);
}

// Set the callback when the instance reaches the end of the path
function AddPathEndCallback(p_callback, p_persistant)
{
	AddPathPointCallback(path_get_number(m_pathIndex)-1, p_callback, p_persistant);
}

// Set a callback when the instance reaches the beginning of the path
function AddPathBeginCallback(p_callback, p_persistant)
{
	AddPathPointCallback(0, p_callback, p_persistant);
}

function FreezeAnimationAtEnd(p_spriteIndex, p_mirrored)
{
	PlayAnimation(p_spriteIndex, p_mirrored, noone);
	image_index = sprite_get_number(p_spriteIndex) - 1;
	image_speed = 0;
}

function FreezeAnimationAtEnd2(p_spriteIndex)
{
	FreezeAnimationAtEnd(p_spriteIndex, m_mirrored);
}

// Mirror the instance
function Mirror(p_mirror)
{
	if(p_mirror)
	{
		m_mirrored = true;
		image_xscale = -1.0;
	}
	else
	{
		m_mirrored = false;
		image_xscale = 1.0;
	}
}

m_pathIndex = noone;
m_callbackAnimationEnd = noone;
m_pathCallbacks = ds_list_create();

// HACK: define mirrored here
m_mirrored = false;