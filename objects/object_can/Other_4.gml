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
	
	instance_hallwayUpMemory.m_playedCan = true;
}

// Check if Mimi already interacted with the can
if(instance_hallwayUpMemory.m_playedCan == false)
{
	var collisionContext = new CollisionContext(GetPlayerInstance(), ActivateCan);
	collisionContext.AddGlobalState1(GlobalGameStates.MimiChecksOnYoungster);
	collisionContext.ExecuteOnHit();
	AddCollisionContext(collisionContext);
}
else
{
	FreezeAnimationAtEnd2(foreground_can);
}


// Only set itself true on certain global states
if(GetGlobalGameState() == GlobalGameStates.MimiChecksOnYoungster)
{
	visible = true;
}
else
{
	visible = false;
}