// Changes the room to the one provided room name (as string)
// TODO; remove the s
function ChangeRooms(p_roomName)
{
	// Get the roomIndex from the roomName
	var room2Index = asset_get_index(p_roomName);
	assert(room2Index != -1, "The room doesn't exist with that name");
	
	// Reset the global backgroundInstance
	ResetBackgroundInstance()
	
	// Change room
	room_goto(room2Index);
}

function CreateFader(p_fadeState, p_fadeSpeed, p_callback)
{
	// TODO: check if layer exists
	var roomFader = instance_create_layer(0, 0, "layer_ui", object_roomFader);
	roomFader.SetFadeState(p_fadeState);
	roomFader.SetFadingSpeed(p_fadeSpeed);
	roomFader.SetCallback(p_callback);
}

// TODO: make this prettier
// Changes the room to the one provided room name (as string), and set the path and position
global.m_path = noone;
global.m_position = 0.0;
global.m_mirrored = false;
// TODO: remove the s
function ChangeRoomAndSetPath(p_roomName, p_path, p_position, p_mirrored)
{
	ChangeRooms(p_roomName);
	// Set the PlayerPath when all objects are created.
	global.m_path = p_path;
	global.m_position = p_position;
	global.m_mirrored = p_mirrored;
	var postRoomLoadCallback = function()
	{
		PlayerSetPath(global.m_path, global.m_position);
		PlayerSetMirrored(global.m_mirrored);
	}
	AddPostRoomLoadCallback(postRoomLoadCallback);
}

// Reloads the current room
function ReloadRoom()
{
	ResetBackgroundInstance();
	room_goto(room);
	
	// Set the PlayerPath when all objects are created.
	var postRoomLoadCallback = function()
	{
		PlayerSetPath(global.m_path, global.m_position);
	}
	AddPostRoomLoadCallback(postRoomLoadCallback);
}