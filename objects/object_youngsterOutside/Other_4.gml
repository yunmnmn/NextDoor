if(GetGlobalGameState() == GlobalGameStates.MimiGetsDrink)
{
	instance_outsideMemory.SetYoungsterOutsideVisible(true);
}

if(GetGlobalGameState() == GlobalGameStates.MimiReturnsFromDrinking)
{
	instance_youngsterOutside.PlayAnimation2(sprite_youngsterCornerIdle, noone);
}
else
{
	instance_youngsterOutside.PlayAnimation2(sprite_youngsterCornerIdleShadow, noone);
}

if(GetGlobalGameState() == GlobalGameStates.MimiGetsDrink)
{
	m_useShadowMap = false;
}
else
{
	m_useShadowMap = true;
}

talkToScaredYoungster = function()
{
	// Start the conversation
	finishConversation = function()
	{
		// Enable the control for the player
		SetControlState(PlayerControlState.PlayerControl);
		
		// HACK: This must be added again in order for it to be able to trigger again
		var collisionContext = new CollisionContext(GetPlayerInstance(), talkToScaredYoungster);
		collisionContext.AddGlobalState2(GlobalGameStates.MimiGetsDrink, GlobalGameStates.MimiReturnsFromDrinking);
		AddCollisionContext(collisionContext);
	}
	var c41_1 = new TextContext(sprite_mimiAvatarTroubled, true, finishConversation);
	c41_1.AddSubText(new SubText("I'll leave him be...", 0.4, true));
	RenderText(c41_1);
	
	// Disable the control for the player
	SetControlState(PlayerControlState.PlayerNoControl);
}

AddTalkingToScaredYoungster = function()
{
	var collisionContext = new CollisionContext(GetPlayerInstance(), talkToScaredYoungster);
	collisionContext.AddGlobalState2(GlobalGameStates.MimiGetsDrink, GlobalGameStates.MimiReturnsFromDrinking);
	AddCollisionContext(collisionContext);
}

if(GetGlobalGameState() == GlobalGameStates.MimiReturnsFromDrinking)
{
	AddTalkingToScaredYoungster();
}

