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
	MimiGetsDrink
	
}

function SetControlState(p_controlState)
{
	global.g_playerControlState = p_controlState;
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
function PostRoomLoadCallback()
{
	if(global.m_postRoomLoadCallback != noone)
	{
		global.m_postRoomLoadCallback();
		global.m_postRoomLoadCallback = noone;
	}
}

function SetPostRoomLoadCallback(p_callback)
{
	// Check if the background instance is 0 first
	assert(global.m_postRoomLoadCallback == noone, "There is already a Post RoomLoad Callback registered");
	global.m_postRoomLoadCallback = p_callback;
}

// --- Global variables used to store the game states ---

// Global game state. Each object will manage its own behaviour depending on this global state
global.m_globalGameState = GlobalGameStates.MimiRoomSits;

// By default, give the player control over mimi
global.g_playerControlState = noone;

// Let the background instance assign the global via the function
global.g_backgroundInstance = noone;

// Let the textbox instance assign itself to the global via the function
global.g_textboxInstance = noone;

// Set the player instance
global.g_playerInstance = noone;

// This will be called by the room initializer after all objects are loaded
global.m_postRoomLoadCallback = noone;