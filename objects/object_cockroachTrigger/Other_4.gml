ActivateCockroach = function()
{
	// Set the cockroach visible and play the animation
	instance_cockroach.visible = true;
	instance_cockroach.image_speed = 1;
	instance_cockroach.image_index = 0;
}

// Only play the cockroach if it hasn't played yet
if(instance_hallwayUpMemory.m_playedCockroach == false)
{
	instance_hallwayUpMemory.m_playedCockroach = true;
	
	var collisionContext = new CollisionContext(GetPlayerInstance(), ActivateCockroach);
	collisionContext.AddGlobalState1(GlobalGameStates.MimiChecksOnYoungster);
	collisionContext.ExecuteOnHit();
	AddCollisionContext(collisionContext);
}
