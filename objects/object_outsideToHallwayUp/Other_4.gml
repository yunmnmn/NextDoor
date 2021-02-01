// Transition Mimi's HallwayDown -> Room when Mimi interacts with the trigger
function collisionEvent()
{
	// Don't give the control to the player while transitioning
	SetControlState(PlayerControlState.PlayerNoControl);

	// Fade, and when finished, load the hallway
	var fadeEndCallback = function()
	{
		SetControlState(PlayerControlState.PlayerControl);
		ChangeRoomAndSetPath("room_hallwayUp", path_hallwayUp, 0.999, true);
	}
	CreateFader(FadeState.FadeOut, 0.01, fadeEndCallback);
}

var collisionContext = new CollisionContext(GetPlayerInstance(), collisionEvent);
collisionContext.AllStates();
AddCollisionContext(collisionContext);