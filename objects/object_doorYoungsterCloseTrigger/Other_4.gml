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
	PlayRoomMusicAt(music_metalHallway, "Metal", true, 200, 230, 400, 2000, 1, true, 1);
	// Set the volume
	SoundGain(GetRoomMusic(), 0.6, 1.0);
}

var collisionContext = new CollisionContext(GetPlayerInstance(), YoungsterClosesDoor);
collisionContext.AddGlobalState1(GlobalGameStates.MimiWalksToOldtimer);
collisionContext.ExecuteOnHit();
AddCollisionContext(collisionContext);