
// --- Debug ---

global.m_debug = false;
global.m_html = !(os_browser == browser_not_a_browser);

global.m_targetRoomSpeed = 60.0;

// --- Enums ---

// Enum to set Mimi's states
enum PlayerControlState
{
	PlayerControl,		// When this state is set, the player can control Mimi 
	PlayerNoControl,	// When this state is set, the player has no control of Mimi
	Talking,			// When this state is set, the player has no control of Mimi, and is in a talking state
}

enum RoomType
{
	Appartment,
	Hallway,
	Outside
}

// TODO: remove the s
enum GlobalGameStates
{
	// Sequence 1 states
	MimiRoomSits,
	MimiGoingToYoungster, 
	MimiGoingToKnockAtNeighbour,
	MimiWalksIntoWoman,
	MimiWalksToOldtimer,
	
	// Sequence 2 states 
	MimiWalksBackToRoom,
	MimiRoomSits2,
	MimiGetsDrink,
	
	// Sequence 3 states
	MimiReturnsFromDrinking,	
	MimiChecksOnYoungster,
	MimiEntersYoungstersRoom,
	MimiLooksAround,
	MimiApproachesHole,
	MimiIsPeeking,
	MimiLocksPeeking,
	MimiIsShocked, 
	MimiPeepsAgain,
	WomenLooksAtMimi,
	MimiFallsBackwards,
	
	// Sequence 4 states
	MimiStandsUpFromAttack,
	MimiHearsTickingAtWindow,
	MimiGetsChased,
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

// Set Mimi scared
global.g_mimiScared = false;

// Set Mimi crawling
global.g_mimiCrawling = false;

// This will be called by the room initializer after all objects are loaded
global.m_postRoomLoadCallbacks = ds_list_create();

// This will be set by the global_instance. It's used to render combined shadow values in the room
global.m_shadowSurfaceInstance = noone;

// Set ending caught or not
global.m_mimiCaught = true;

// Disable all triggers for Mimi
global.m_disableAllTriggers = false;

// Controller index
global.m_controllerIndex = noone;
global.m_controllerVibrationFactor = 0.0;

// Sound groups
global.m_soundGroups = ds_list_create();

// Default fading speed
global.m_defaultFadingSpeed = 0.0005;

// Average delta in seconds
global.averageDeltaTimeInMiliseconds = noone;

global.historySize = 32;
global.fpsHistory = array_create(global.historySize, 0);
global.frameIndex = 0;

global.audioListenerPositonX = 0.0;
global.audioListenerPositonY = 0.0;

function DebugMode()
{
	return global.m_debug;
}

function HtmlMode()
{
	return global.m_html;
}

function GetDefaultFadingSpeed()
{
	return global.m_defaultFadingSpeed;
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

function SetMimiCaught(p_caught)
{
	global.m_mimiCaught = p_caught;
}

function GetMimiCaught()
{
	return global.m_mimiCaught;
}

function SetMimiCrawling(p_crawling)
{
	global.g_mimiCrawling = p_crawling;
}

function GetMimiCrawling()
{
	return global.g_mimiCrawling;
}

function GetControlState()
{
	return global.g_playerControlState;
}

function GetTextboxInstance()
{
	return global.g_textboxInstance;
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
function ExecutePostRoomLoadCallbacks(p_roomInstance)
{
	for(var i = 0; i < ds_list_size(global.m_postRoomLoadCallbacks); i++)
	{
		var postRoomLoadContext = ds_list_find_value(global.m_postRoomLoadCallbacks, i);
		if(postRoomLoadContext.m_callback != noone)
		{
			postRoomLoadContext.m_callback(p_roomInstance);
		}
		
		// Clean memory
		postRoomLoadContext.Free();
		delete postRoomLoadContext;
	}
	
	ds_list_clear(global.m_postRoomLoadCallbacks);
}

function AddPostRoomLoadCallback(p_callback)
{
	ds_list_add(global.m_postRoomLoadCallbacks, p_callback);
}

function SetDisableAllTriggers(disableAllTriggers)
{
	global.m_disableAllTriggers = disableAllTriggers;
}

function GetDisableAllTriggers()
{
	return global.m_disableAllTriggers;
}

function GetControllerIndex()
{
	return global.m_controllerIndex;
}

function SetControllerIndex(p_controllerIndex)
{
	// Early out if the controller index is the same
	if(global.m_controllerIndex == p_controllerIndex)
	{
		return;
	}
	
	// Set the vibration of the controller to 0 if the controller was ever valid
	if(global.m_controllerIndex != noone)
	{
		gamepad_set_vibration(global.m_controllerIndex, 0.0, 0.0);
	}
	
	global.m_controllerIndex = p_controllerIndex;
	
	// Set the deadzone
	gamepad_set_axis_deadzone(global.m_controllerIndex , 0.4);
}

function SetControllerVibrationFactor(p_factor)
{
	global.m_controllerVibrationFactor = p_factor;
}

function GetControllerVibrationFactor()
{
	return global.m_controllerVibrationFactor;
}