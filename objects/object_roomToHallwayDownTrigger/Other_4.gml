var collisionEvent = function()
{	
	// Remove the pressing button prompt
	instance_global.DrawActionPressPrompt(false, 0, 0);
	
	// Don't give the control to the player while transitioning
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Set Mimi to idle
	PlayerPlayAnimation2(PlayerGetIdleSprite(), noone);
	
	// Fade, and when finished, load the hallway
	var fadeEndCallback = function()
	{
		SetControlState(PlayerControlState.PlayerControl);
		var pathPosition = SnapToClosestPosition(path_hallwayDown, 224, 348);
		ChangeRoomAndSetPath(room_hallwayDown, path_hallwayDown, pathPosition, false);
	}
	CreateFader(FadeState.FadeOut, GetDefaultFadingSpeed(), fadeEndCallback);
	audio_play_sound(foley_appartmentDoorOpen, 1, false);
}
var collisionContext = new CollisionContext(GetPlayerInstance(), collisionEvent);
collisionContext.AllStates();
AddCollisionContext(collisionContext);

// HACK: prompt the controls
if(GetGlobalGameState() == GlobalGameStates.MimiRoomSits)
{
	var promptEvent = function()
	{
		instance_global.DrawActionPressPrompt(true, 709, 52);
	}
	var collisionContext2 = new CollisionContext(GetPlayerInstance(), promptEvent);
	collisionContext2.AddGlobalState1(GlobalGameStates.MimiGoingToYoungster);
	collisionContext2.ExecuteOnHit();
	AddCollisionContext(collisionContext2);
}