// Transition Mimi's HallwayDown -> Outside(down) when Mimi interacts with the trigger
function collisionEvent()
{
	// Don't give the control to the player while transitioning
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Set Mimi to idle
	PlayerPlayAnimation2(PlayerGetIdleSprite(), noone);
	
	// Fade, and when finished, load the hallway
	{
		var fadeEndCallback = function()
		{
			SetControlState(PlayerControlState.PlayerControl);
			ChangeRoomAndSetPath(room_outside, path_outsideLow, 0.001, false);
		}
		CreateFader(FadeState.FadeOut, GetDefaultFadingSpeed(), fadeEndCallback);
	}
}

var collisionContext = new CollisionContext(GetPlayerInstance(), collisionEvent);
collisionContext.AllStates();
AddCollisionContext(collisionContext);