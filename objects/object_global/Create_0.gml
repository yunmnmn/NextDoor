// Enum to set Mimi's states
enum PlayerControlState
{
	PlayerControl,		// When this state is set, the player can control Mimi 
	PlayerNoControl,	// When this state is set, the player has no control of Mimi
	Talking,			// When this state is set, the player has no control of Mimi, and is in a talking state
}

// --- Global variables used to store the game states ---
// By default, give the player control over mimi
global.g_playerControlState = PlayerControlState.PlayerControl;

// Let the background instance assign the backgroundInstance to the global
global.backgroundInstance = 0;