YoungsterClosesDoor = function()
{
	// Close the door when Mimi hits the trigger
	instance_hallwayUpMemory.SetDoorYoungsterVisible(false);
	instance_hallwayUpMemory.SetYoungsterVisible(false);
	
	// Delete all trigger contexts on the youngster
	instance_youngster.DeleteAllCollisionContexts();
		
	// Set the following speed back to instant
	SetViewportFollowSpeed(1.0);
	
	// Add another collision event at the youngsterDoorTrigger
	instance_youngsterDoorTrigger.AddDialogueAfterYoungsterSlamsDoor();
	
	// Play the muffled metal version again
	// Register the current room music first
	RegisterSoundGroupFromMusic(GetRoomMusicGroup(), GetRoomMusic());
	// Play the new room music
	PlayRoomMusicAt(music_metalHallway, "Metal", true, 200, 230, 70, 2000, 1.5, true, 1);
	// Set the volume
	SoundGain(GetRoomMusic(), 0.6, 1.0);
	
	// Play the Youngster Doorslam
	PlaySoundAt(foley_hallwayYoungsterDoorSlam, 200, 230, 400, 2000, 1, false, 10.0);
	
	// Rumble the controller when the Youngster slams the door
	Rumble(0.9, 200);
}

var collisionContext = new CollisionContext(GetPlayerInstance(), YoungsterClosesDoor);
collisionContext.AddGlobalState1(GlobalGameStates.MimiWalksToOldtimer);
collisionContext.ExecuteOnHit();
AddCollisionContext(collisionContext);