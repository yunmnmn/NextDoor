function RegisterPlayerInstance(p_player)
{
	assert_fail(p_player == noone, "Player instance is invalid");
	global.g_playerInstance = p_player;
}

function PlayerSetPath(p_pathIndex)
{
	assert_fail(p_pathIndex == noone, "Path is invalid");
	global.g_playerInstance.SetPath(p_pathIndex);
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