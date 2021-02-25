// Start the can not playing
image_speed = 0;
image_index = 0;

ActivateCan = function()
{
	CanFinished = function()
	{
		FreezeAnimationAtEnd2(foreground_can);
	}
	
	// Start the can falling animation
	PlayAnimation2(foreground_can, CanFinished);
}

var collisionContext = new CollisionContext(GetPlayerInstance(), ActivateCan);
collisionContext.AddGlobalState1(GlobalGameStates.MimiChecksOnYoungster);
collisionContext.ExecuteOnHit();
AddCollisionContext(collisionContext);

// Only set itself true on certain global states
if(GetGlobalGameState() == GlobalGameStates.MimiChecksOnYoungster)
{
	visible = true;
}
else
{
	visible = false;
}