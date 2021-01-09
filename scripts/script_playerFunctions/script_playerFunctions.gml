function RegisterPlayerInstance(p_player)
{
	assert_fail(p_player == noone, "Player instance is invalid");
	global.g_playerInstance = p_player;
}

function PlayerSetPath(p_pathIndex, p_position)
{
	assert_fail(p_pathIndex == noone, "Path is invalid");
	global.g_playerInstance.SetPath(p_pathIndex, p_position);
}

function PlayerSetPathEndCallback(p_callback)
{
	global.g_playerInstance.SetPathEndCallback(p_callback);
}

function PlayerSetPathStartCallback(p_callback)
{
	global.g_playerInstance.SetPathStartCallback(p_callback);
}

function PlayerAddPathCallback(p_pathIndex, p_position, p_callback, p_persistant)
{
	global.g_playerInstance.AddPathCallback(new PathCallback(p_pathIndex, p_position, p_callback, p_persistant));
}

function PlayerGetPath()
{
	global.g_playerInstance.GetPath();
}

function PlayerPlayAnimation(p_spriteIndex, p_callbackEnd)
{
	assert_fail(p_spriteIndex == noone, "Passed sprite index is invalid");
	assert_fail(global.g_playerInstance == noone, "Registered sprite is invalid");
	
	global.g_playerInstance.PlayAnimation(p_spriteIndex, p_callbackEnd);
}

function GetPlayerInstance()
{
	assert_fail(global.g_playerInstance == noone, "Player is invalid");
	return global.g_playerInstance;
}