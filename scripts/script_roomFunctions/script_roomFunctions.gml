function CreateFader(p_fadeState, p_fadeSpeed, p_callback)
{
	// TODO: check if layer exists
	var roomFader = instance_create_layer(0, 0, "layer_ui", object_roomFader);
	roomFader.SetFadeState(p_fadeState);
	roomFader.SetFadingSpeed(p_fadeSpeed);
	roomFader.SetCallback(p_callback);
	
	return roomFader;
}

// Changes the room to the one provided room name (as string)
// TODO; remove the s
function ChangeRooms(p_roomInstance)
{
	// Get the roomIndex from the roomName
	assert(p_roomInstance != noone, "The room instance doesn't exist");
	
	// Reset the global backgroundInstance
	ResetBackgroundInstance()
	
	// Change room
	room_goto(p_roomInstance);
}

// TODO: make this prettier
// Changes the room to the one provided room name (as string), and set the path and position
global.m_path = noone;
global.m_position = 0.0;
global.m_mirrored = false;
// TODO: remove the s
function ChangeRoomAndSetPath(p_roomInstance, p_path, p_position, p_mirrored)
{
	ChangeRooms(p_roomInstance);
	// Set the PlayerPath when all objects are created.
	global.m_path = p_path;
	global.m_position = p_position;
	global.m_mirrored = p_mirrored;
	var postRoomLoadCallback = function(p_roomInstance)
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
	var postRoomLoadCallback = function(p_roomInstance)
	{
		PlayerSetPath(global.m_path, global.m_position);
	}
	AddPostRoomLoadCallback(postRoomLoadCallback);
}