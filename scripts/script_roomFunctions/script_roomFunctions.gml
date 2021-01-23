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
	SetPostRoomLoadCallback(postRoomLoadCallback);
}

function CreateFader(p_fadeState, p_fadeSpeed, p_callback)
{
	// TODO: check if layer exists
	var roomFader = instance_create_layer(x, y, "layer_ui", object_roomFader);
	roomFader.SetFadeState(p_fadeState);
	roomFader.SetFadingSpeed(p_fadeSpeed);
	roomFader.SetCallback(p_callback);
}