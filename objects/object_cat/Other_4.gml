CatMeows = function()
{
	conversationFinished = function()
	{
		PlayerPlayAnimation2(sprite_mimiIdleScared, noone);
		
		SetControlState(PlayerControlState.PlayerControl);
	}
	
	cbcat_2 = function()
	{
		var ccat_2 = new TextContext(sprite_mimiAvatarTroubled, true, conversationFinished);
		ccat_2.AddSubText(new SubText("That's an.... ugly cat...", 0.2, true));
		RenderText(ccat_2);
	}
	
	cbcat_1 = function()
	{
		var ccat_1 = new TextContext(sprite_catAvatar, true, cbcat_2);
		ccat_1.AddSubText(new SubText("Meow", 0.2, true));
		RenderText(ccat_1);
	}
	
	CatAnimationFinished = function()
	{
		FreezeAnimationAtEnd2(anim_cat);
		cbcat_1();
	}
	
	// Disable the control for hte player
	SetControlState(PlayerControlState.PlayerNoControl);
	
	mirror = (GetPlayerInstance().x > x) ? true : false;
	walkToPosition = function()
	{			
		GetPlayerInstance().SetPathSpeed(0.0);
		PlayerPlayAnimation(sprite_mimiIdleScared, mirror, noone);
		
		PlayAnimation2(anim_cat, CatAnimationFinished);
	}
	PlayerMoveAndExecute(mirror ? x + 100 : x - 100, GetPlayerInstance().y, 1.0, walkToPosition);
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
}

var collisionContext = new CollisionContext(GetPlayerInstance(), CatFalls);
collisionContext.AddGlobalState1(GlobalGameStates.MimiChecksOnYoungster);
collisionContext.ExecuteOnHit();
AddCollisionContext(collisionContext);

image_speed = 0;