function RegisterPlayerInstance(p_player)
{
	assert(p_player != noone, "Player instance is invalid");
	global.g_playerInstance = p_player;
}

function GetPlayerInstance()
{
	assert(global.g_playerInstance != noone, "Player is invalid");
	return global.g_playerInstance;
}

function PlayerSetPath(p_pathIndex, p_position)
{
	assert(p_pathIndex != noone, "Path is invalid");
	global.g_playerInstance.SetPath(p_pathIndex, p_position);
}

function PlayerSetMirrored(p_mirrored)
{
	global.g_playerInstance.SetMirrored(p_mirrored);
}

function PlayerSetPathStartCallback(p_pathIndex, p_callback, p_persistant, p_pathType)
{
	global.g_playerInstance.AddPathCallback(new PathCallback(p_pathIndex, 0.999, p_callback, p_persistant, p_pathType));
}

function PlayerSetPathEndCallback(p_pathIndex, p_callback, p_persistant, p_pathType)
{
	global.g_playerInstance.AddPathCallback(new PathCallback(p_pathIndex, 0.999, p_callback, p_persistant, p_pathType));
}

function PlayerAddPathCallback(p_pathIndex, p_position, p_callback, p_persistant, p_pathType)
{
	global.g_playerInstance.AddPathCallback(new PathCallback(p_pathIndex, p_position, p_callback, p_persistant, p_pathType));
}

function PlayerGetPath()
{
	return global.g_playerInstance.GetPath();
}

function PlayerPlayAnimation(p_spriteIndex, p_mirrored, p_callbackEnd)
{
	PlayerPlayAnimation2(p_spriteIndex, p_callbackEnd);
	PlayerSetMirrored(p_mirrored);
}

function PlayerPlayAnimation2(p_spriteIndex, p_callbackEnd)
{
	assert(p_spriteIndex != noone, "Passed sprite index is invalid");
	assert(global.g_playerInstance != noone, "Registered sprite is invalid");
	
	global.g_playerInstance.PlayAnimation(p_spriteIndex, p_callbackEnd);
}

function PlayerFreezeAnimation(p_spriteIndex, p_imageIndex, p_mirrored)
{
	PlayerPlayAnimation2(p_spriteIndex, noone);
	GetPlayerInstance().image_index = p_imageIndex;
	GetPlayerInstance().image_speed = 0;
	
	PlayerSetMirrored(p_mirrored);
}

function PlayerGetMirrored()
{
	return GetPlayerInstance().m_mirrored;
}

function PlayerFreezeAnimationEnd(p_spriteIndex, p_mirrored)
{
	PlayerFreezeAnimation(p_spriteIndex, sprite_get_number(image_number) -1, p_mirrored);
}

function PlayerFreezeAnimationEnd2(p_spriteIndex)
{
	PlayerFreezeAnimationEnd(p_spriteIndex, PlayerGetMirrored());
}

function PlayerSnapToClosestPosition(p_positionX, p_positionY, p_disableFollowing)
{
	var position = SnapToClosestPosition(PlayerGetPath(), p_positionX, p_positionY);
	GetPlayerInstance().m_position = position;
	GetPlayerInstance().m_cachedPosition = position;
	GetPlayerInstance().path_position = position;
	GetPlayerInstance().path_positionprevious = position;
	
	if(p_disableFollowing)
	{
		DisableFollowingInstance();
	}
}

function PlayerMoveAndExecute(p_positionX, p_positionY, p_speed, p_callback)
{
	// This can only work in NoControl state
	assert(GetControlState() == PlayerControlState.PlayerNoControl, "This function can only be called when the player is in NoControl state");
	
	GetPlayerInstance().MoveAndExecute(p_positionX, p_positionY, p_speed, p_callback);
}