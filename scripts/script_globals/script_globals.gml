// Enum to set Mimi's states
enum PlayerControlState
{
	PlayerControl,		// When this state is set, the player can control Mimi 
	PlayerNoControl,	// When this state is set, the player has no control of Mimi
	Talking,			// When this state is set, the player has no control of Mimi, and is in a talking state
}

function SetControlState(p_controlState)
{
	global.g_playerControlState = p_controlState;
}

// --- Global variables used to store the game states ---
// By default, give the player control over mimi
global.g_playerControlState = noone;

// Let the background instance assign the global via the function
global.g_backgroundInstance = noone;

// Let the textbox instance assign itself to the global via the function
global.g_textboxInstance = noone;

// Set the player instance
global.g_playerInstance = noone;