// -------------------------- First colliding event --------------------------

// Transition Mimi's HallwayDown -> Room when Mimi interacts with the trigger
function collisionEvent()
{
	// Don't give the control to the player while transitioning
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Set Mimi to idle
	PlayerPlayAnimation2(PlayerGetIdleSprite(), noone);
	
	// Fade, and when finished, load the hallway

	var fadeEndCallback = function()
	{
		SetControlState(PlayerControlState.PlayerControl);
		ChangeRoomAndSetPath(room_mimiRoom, path_mimiRoom, 0.75, true);
	}
	CreateFader(FadeState.FadeOut, GetDefaultFadingSpeed(), fadeEndCallback);
		
	// Play the door sound
	PlaySound(foley_appartmentDoorOpen, 1, false);
}
var collisionContext1 = new CollisionContext(GetPlayerInstance(), collisionEvent);
collisionContext1.m_doNotExecuteOn = true;
collisionContext1.m_promptIndex = anim_doorMark;
collisionContext1.AddGlobalState1(GlobalGameStates.MimiChecksOnYoungster);
AddCollisionContext(collisionContext1);

// -------------------------- Second colliding event --------------------------

// Don't let Mimi outside untill she knocked on the neighbor's door
CannotGoToRoom = function()
{
	conversationFinished = function()
	{			
		// Give control ba ck to the player again
		SetControlState(PlayerControlState.PlayerControl);
		
		// HACK: This must be added again in order for it to be able to trigger again
		var collisionContext = new CollisionContext(GetPlayerInstance(), CannotGoToRoom);
		collisionContext.AddGlobalState1(GlobalGameStates.MimiChecksOnYoungster);
		AddCollisionContext(collisionContext);
	}
	// Start the monologue
	var c30_1 = new TextContext(sprite_mimiAvatarScared, true, conversationFinished);
	c30_1.AddSubText(new SubText("The scream came from upstairs...", 0.3, true));
	RenderText(c30_1);
	
	// Set Mimi to idle
	PlayerPlayAnimation2(sprite_mimiIdleScared, noone);
	
	// Don't give the control to the player while transitioning
	SetControlState(PlayerControlState.PlayerNoControl);
}

var collisionContext2 = new CollisionContext(GetPlayerInstance(), CannotGoToRoom);
collisionContext2.AddGlobalState1(GlobalGameStates.MimiChecksOnYoungster);
AddCollisionContext(collisionContext2);