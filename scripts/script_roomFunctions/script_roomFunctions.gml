// Changes the room to the one provided room name (as string)
function ChangeRooms(p_roomName, p_path, p_position)
{
	// Get the roomIndex from the roomName
	var room2Index = asset_get_index(p_roomName);
	assert_fail(room2Index == -1, "The room doesn't exist with that name");
	
	// Reset the global backgroundInstance
	ResetBackgroundInstance()
	
	// Change room
	room_goto(room2Index);
	
	// Set the PlayerPath when all objects are created.
	m_path = p_path;
	m_position = p_position;
	var postRoomLoadCallback = function()
	{
		PlayerSetPath(m_path, m_position);
	}
	SetPostRoomLoadCallback(postRoomLoadCallback);
}

// Reloads the current room
function ReloadRoom()
{
	ResetBackgroundInstance();
	room_goto(room);
}

function CreateFader(p_fadeState, p_fadeSpeed, p_callback)
{
	// TODO: check if layer exists
	var roomFader = instance_create_layer(x, y, "layer_ui", object_roomFader);
	roomFader.SetFadeState(p_fadeState);
	roomFader.SetFadingSpeed(p_fadeSpeed);
	roomFader.SetCallback(p_callback);
}