CatMeows = function()
{
	conversationFinished = function()
	{
		PlayerPlayAndFreezeAtEnd(anim_mimiIdleToScared, PlayerGetMirrored());
		
		SetControlState(PlayerControlState.PlayerControl);
	}
	
	cb31_3 = function()
	{
		var c31_3 = new TextContext(sprite_mimiAvatarScared, true, conversationFinished);
		c31_3.AddSubText(new SubText("It has a cursed face...", 0.3, true));
		RenderText(c31_3);
	}

	cb31_2 = function()
	{
		var c31_2 = new TextContext(sprite_mimiAvatarScared, true, cb31_3);
		c31_2.AddSubText(new SubText("Who's cat is this?", 0.4, true));
		RenderText(c31_2);
	}
	
	cb31_1 = function()
	{
		var c31_1 = new TextContext(sprite_catAvatar, true, cb31_2);
		c31_1.AddSubText(new SubText("Meow!", 0.6, true));
		RenderText(c31_1);
		
		// Play the meow sound
		PlaySound(foley_outsideCatMeow, 10, false);
	}
	
	CatAnimationFinished = function()
	{
		FreezeAnimationAtEnd2(anim_cat);
		cb31_1();
	}
	
	// Disable the control for hte player
	SetControlState(PlayerControlState.PlayerNoControl);
	
	instance_outsideMemory.m_talkedToCat = true;
	
	mirror = (GetPlayerInstance().x > x) ? true : false;
	walkToPosition = function()
	{			
		GetPlayerInstance().SetPathSpeed(0.0);
		PlayerPlayAndFreezeAtEnd(sprite_mimiIdleScared, mirror);
		
		PlayAnimation2(anim_cat, CatAnimationFinished);
	}
	PlayerMoveAndExecute(mirror ? x + 60 : x - 60, GetPlayerInstance().y, 1.0, walkToPosition);
}

CatIsOnTheGround = function()
{
	FreezeAnimationAtEnd2(anim_catFall);
	
	// Add another collider, but this time it requires an action
	var collisionContext = new CollisionContext(GetPlayerInstance(), CatMeows);
	collisionContext.AddGlobalState1(GlobalGameStates.MimiChecksOnYoungster);
	AddCollisionContext(collisionContext);
}

CatFalls = function()
{
	PlayAnimation2(anim_catFall, CatIsOnTheGround);
	mask_index = anim_cat;
	
	instance_outsideMemory.m_playedCat = true;
}

// Check if Mimi already interacted with the cat
if(instance_outsideMemory.m_playedCat = false)
{
	var collisionContext = new CollisionContext(GetPlayerInstance(), CatFalls);
	collisionContext.AddGlobalState1(GlobalGameStates.MimiChecksOnYoungster);
	collisionContext.ExecuteOnHit();
	AddCollisionContext(collisionContext);
}
else
{
	// Triggered the cat, but haven't talked to it yet
	if(!instance_outsideMemory.m_talkedToCat)
	{
		FreezeAnimationAtEnd2(anim_catFall);
		mask_index = anim_cat;
		
		// Add another collider, but this time it requires an action
		var collisionContext = new CollisionContext(GetPlayerInstance(), CatMeows);
		collisionContext.AddGlobalState1(GlobalGameStates.MimiChecksOnYoungster);
		AddCollisionContext(collisionContext);
	}
	else
	{
		// Did talk to the cat already
		FreezeAnimationAtEnd2(anim_cat);
	}
}

image_speed = 0;

// Only be visible from sequence 3 onwards
if(GetGlobalGameState() >= GlobalGameStates.MimiChecksOnYoungster)
{
	visible = true;
}
else
{
	visible = false;
}

// -------------------------- Sounds --------------------------

// Set the sound for cat fall
var catFall = new SoundContext(foley_outsideCatFall, anim_catFall, 3);
catFall.SetPersistent(false);
AddSoundContext(catFall);