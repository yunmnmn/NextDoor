// Progress to sequence 4
if(keyboard_check(vk_shift) && DebugMode())
{
	if(GetTextboxInstance() != noone)
	{
		GetTextboxInstance().Reset();
	}
	
	// Set the PlayerPath when all objects are created.
	var postRoomLoadCallback = function(p_roomInstance)
	{
		// Follow the player again
		SetViewportFollowInstance(GetPlayerInstance());
		
		// Play the Women timeline
		PlayTimeline(timeline_womenMoves);
		
		// Give the player the ControlState
		SetControlState(PlayerControlState.PlayerControl);
	}
	AddPostRoomLoadCallback(postRoomLoadCallback);
	
	SetGlobalGameState(GlobalGameStates.MimiStandsUpFromAttack);
	ChangeRoomAndSetPath(room_youngsterRoom, path_youngsterRoom, 0.45, true);
}