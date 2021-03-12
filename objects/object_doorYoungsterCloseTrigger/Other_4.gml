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
}

var collisionContext = new CollisionContext(GetPlayerInstance(), YoungsterClosesDoor);
collisionContext.AddGlobalState1(GlobalGameStates.MimiWalksToOldtimer);
collisionContext.ExecuteOnHit();
AddCollisionContext(collisionContext);