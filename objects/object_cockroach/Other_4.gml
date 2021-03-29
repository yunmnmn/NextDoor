image_speed = 0;
image_index = 0;
visible = false;

ActivateBug = function()
{
	CanFinished = function()
	{
		FreezeAnimationAtEnd2(foreground_cockroach);
		visible = false;
	}
	
	// Start the can falling animation
	PlayAnimation2(foreground_cockroach, CanFinished);
	
	instance_hallwayUpMemory.m_playedCockroach = true;
	visible = true;
}

// Check if Mimi already interacted with the can
if(instance_hallwayUpMemory.m_playedCockroach == false)
{
	var collisionContext = new CollisionContext(GetPlayerInstance(), ActivateBug);
	collisionContext.AddGlobalState1(GlobalGameStates.MimiChecksOnYoungster);
	collisionContext.ExecuteOnHit();
	AddCollisionContext(collisionContext);
}

// -------------------------- Sounds --------------------------

// Set the sound for the falling can
var bugSoundContext = new SoundContext(foley_hallwayBug, foreground_cockroach, 1);
bugSoundContext.SetPersistent(false);
AddSoundContext(bugSoundContext);