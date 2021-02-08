// Enum to set Mimi's states
enum PlayerControlState
{
	PlayerControl,		// When this state is set, the player can control Mimi 
	PlayerNoControl,	// When this state is set, the player has no control of Mimi
	Talking,			// When this state is set, the player has no control of Mimi, and is in a talking state
}

// TODO: remove the s
enum GlobalGameStates
{
	// Sequence 1 states
	MimiRoomSits,
	MimiGoingToYoungster, 
	MimiGoingToKnockAtNeighbour,
	MimiGointToYoungsterAgain,
	MimiWalksIntoWoman,
	MimiWalksToOldtimer,
	MimiWalksBackToRoom,
	
	// Sequence 2 states 
	MimiRoomSits2,
	MimiGetsDrink,
	
	// Sequence 3 states
	MimiReturnsFromDrinking,	
	MimiChecksOnYoungster,
	MimiEntersYoungstersRoom,
	MimiApproachesHole,
	MimiIsPeeking,
	MimiLocksPeeking,
	MimiIsShocked, 
}

function SetControlState(p_controlState)
{
	global.g_playerControlState = p_controlState;
}

function SetMimiScared(p_scared)
{
	global.g_mimiScared = p_scared;
}

function GetMimiScared()
{
	return global.g_mimiScared;
}

function GetControlState()
{
	return global.g_playerControlState;
}

function GetGlobalGameState()
{
	return global.m_globalGameState;
}

function SetGlobalGameState(p_globalGameState)
{
	global.m_globalGameState = p_globalGameState;
}

// This will be called by the room initializer after all objects are loaded
function ExecutePostRoomLoadCallbacks()
{
	for(i = 0; i < ds_list_size(global.m_postRoomLoadCallbacks); i++)
	{
		var pathCallback = ds_list_find_value(global.m_postRoomLoadCallbacks, i);
		pathCallback();
	}
	
	ds_list_clear(global.m_postRoomLoadCallbacks);
}

function AddPostRoomLoadCallback(p_callback)
{
	ds_list_add(global.m_postRoomLoadCallbacks, p_callback);
}

// --- Global variables used to store the game states ---

// Global game state. Each object will manage its own behaviour depending on this global state
global.m_globalGameState = GlobalGameStates.MimiRoomSits;

// By default, give the player control over mimi
global.g_playerControlState = PlayerControlState.PlayerNoControl;

// Let the background instance assign the global via the function
global.g_backgroundInstance = noone;

// Let the textbox instance assign itself to the global via the function
global.g_textboxInstance = noone;

// Set the player instance
global.g_playerInstance = noone;

// Set mimi scared
global.g_mimiScared = false;

// This will be called by the room initializer after all objects are loaded
global.m_postRoomLoadCallbacks = ds_list_create();