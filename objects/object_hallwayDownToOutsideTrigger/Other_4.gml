// Transition Mimi's HallwayDown -> Outside(down) when Mimi interacts with the trigger
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
		var pathPosition = SnapToClosestPosition(path_outsideLow, 342, 776);
		ChangeRoomAndSetPath(room_outside, path_outsideLow, pathPosition, false);
	}
	CreateFader(FadeState.FadeOut, GetDefaultFadingSpeed(), fadeEndCallback);
		
	// Play the door sound
	PlaySound(foley_hallwayDoorOpen, 1, false);
}
var collisionContext = new CollisionContext(GetPlayerInstance(), collisionEvent);
collisionContext.AllStates();
collisionContext.m_promptIndex = anim_doorMark;
AddCollisionContext(collisionContext);