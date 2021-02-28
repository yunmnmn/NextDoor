var collisionEvent = function()
{	
	// Don't give the control to the player while transitioning
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Set Mimi to idle
	PlayerPlayAnimation2(PlayerGetIdleSprite(), noone);
	
	// Fade, and when finished, load the hallway
	var fadeEndCallback = function()
	{
		SetControlState(PlayerControlState.PlayerControl);
		ChangeRoomAndSetPath("room_hallwayDown", path_hallwayDown, 0.01, false);
	}
	CreateFader(FadeState.FadeOut, GetDefaultFadingSpeed(), fadeEndCallback);
}
var collisionContext = new CollisionContext(GetPlayerInstance(), collisionEvent);
collisionContext.AllStates();
AddCollisionContext(collisionContext);


if(GetGlobalGameState() == GlobalGameStates.MimiRoomSits)
{

	var promptEvent = function()
	{
		instance_global.DrawActionPressPrompt(true, 700, 60);
	}
	var collisionContext2 = new CollisionContext(GetPlayerInstance(), promptEvent);
	collisionContext2.AddGlobalState1(GlobalGameStates.MimiGoingToYoungster);
	collisionContext2.ExecuteOnHit();
	AddCollisionContext(collisionContext2);
}