// Progress to sequence 4
if(keyboard_check(vk_shift) && DebugMode())
{
	// Follow the player again
	SetViewportFollowInstance(GetPlayerInstance());
	
	instance_textbox.Reset();
	
	// Set the PlayerPath when all objects are created.
	var postRoomLoadCallback = function()
	{
		// Play the Women timeline
		PlayTimeline(timeline_womenMoves);
		SetControlState(PlayerControlState.PlayerControl);
	}
	AddPostRoomLoadCallback(postRoomLoadCallback);
	
	SetGlobalGameState(GlobalGameStates.MimiStandsUpFromAttack);
	ChangeRoomAndSetPath(room_youngsterRoom, path_youngsterRoom, 0.45, true);
}