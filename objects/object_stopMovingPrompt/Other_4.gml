StopMovingPrompt = function()
{		
	instance_global.DrawMovingPrompt(false, 0, 0);
}

var collisionContext = new CollisionContext(GetPlayerInstance(), StopMovingPrompt);
collisionContext.AddGlobalState1(GlobalGameStates.MimiGoingToYoungster);
collisionContext.ExecuteOnHit();
AddCollisionContext(collisionContext);