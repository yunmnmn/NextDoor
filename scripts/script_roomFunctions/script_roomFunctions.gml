function ChangeRooms(roomName)
{
	// Get the roomIndex from the roomName
	var room2Index = asset_get_index(roomName);
	assert_fail(room2Index == -1, "The room doesn't exist with that name");
	
	// Reset the global backgroundInstance
	ResetBackgroundInstance()
	
	// Change room
	room_goto(room2Index);
}