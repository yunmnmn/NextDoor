YoungsterClosesDoor = function()
{
	// Close the door when Mimi hits the trigger
	instance_hallwayUpMemory.SetDoorYoungsterVisible(false);
	instance_hallwayUpMemory.SetYoungsterVisible(false);
		
	// Set the following speed back to instant
	SetViewportFollowSpeed(1.0);
}

var collisionContext = new CollisionContext(GetPlayerInstance(), YoungsterClosesDoor);
collisionContext.AddGlobalState1(GlobalGameStates.MimiWalksToOldtimer);
collisionContext.ExecuteOnHit();
AddCollisionContext(collisionContext);