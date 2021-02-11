// -------------------------- First colliding event --------------------------

function NobodyIsHereConversation()
{
	conversationFinished = function()
	{
		// Give control to the player after the conversation is over
		SetControlState(PlayerControlState.PlayerControl);
	}
	
	cb15_2 = function()
	{	
		var c13_2 = new TextContext(sprite_mimiAvatarTroubled, true, conversationFinished);
		c13_2.AddSubText(new SubText("Nobody's home…", 0.2, true));
		RenderText(c13_2);
	}

	// Start of the conversation. Doesn't require a function
	var c15_1 = new TextContext(sprite_mimiAvatarTroubled, true, cb15_2);
	c15_1.AddSubText(new SubText("That's weird", 0.6, true));
	RenderText(c15_1);
}

NobodyIshere = function()
{	
	// Disable the control the player has
	SetControlState(PlayerControlState.PlayerNoControl);
		
	// Set the idle animation
	PlayerPlayAnimation(sprite_mimiIdleScared, true, noone);
		
	// Play the conversation with the women in black
	NobodyIsHereConversation();
}

var collisionContext1 = new CollisionContext(GetPlayerInstance(), NobodyIshere);
collisionContext1.AddGlobalState1(GlobalGameStates.MimiEntersYoungstersRoom);
collisionContext1.ExecuteOnHit();
AddCollisionContext(collisionContext1);

// -------------------------- Second colliding event --------------------------

//var doorCollisionEvent = function()
//{
//	// Don't give the control to the player while transitioning
//	SetControlState(PlayerControlState.PlayerNoControl);
//	// Fade, and when finished, load the hallway
//	var fadeEndCallback = function()
//	{
//		SetControlState(PlayerControlState.PlayerControl);
//		ChangeRoomAndSetPath("room_hallwayUp", path_hallwayUp, 0.01, false);
//	}
//	CreateFader(FadeState.FadeOut, 0.01, fadeEndCallback);
//}

//var collisionContext2 = new CollisionContext(GetPlayerInstance(), doorCollisionEvent);
//collisionContext2.AllStates();
//AddCollisionContext(collisionContext2);
