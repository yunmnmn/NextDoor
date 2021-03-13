// Going to the ending sequence
GameEndingRoom = function()
{	
	var TransitionToEndingRoom = function()
	{
		ChangeRooms(room_ending);
	}
	CreateFader(FadeState.FadeOut, GetDefaultFadingSpeed(), TransitionToEndingRoom);
	
	// Don't give the control to the player while transitioning
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Set that Mimi wasn't caught
	SetMimiCaught(false);
}

var endingCollisionContext = new CollisionContext(GetPlayerInstance(), GameEndingRoom);
endingCollisionContext.AddGlobalState1(GlobalGameStates.MimiGetsChased);
endingCollisionContext.ExecuteOnHit();
AddCollisionContext(endingCollisionContext);