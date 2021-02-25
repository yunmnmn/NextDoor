ActivateCockroach = function()
{
	// Set the cockroach visible and play the animation
	instance_cockroach.visible = true;
	instance_cockroach.image_speed = 1;
	instance_cockroach.image_index = 0;
}

var collisionContext = new CollisionContext(GetPlayerInstance(), ActivateCockroach);
collisionContext.AddGlobalState1(GlobalGameStates.MimiChecksOnYoungster);
collisionContext.ExecuteOnHit();
AddCollisionContext(collisionContext);