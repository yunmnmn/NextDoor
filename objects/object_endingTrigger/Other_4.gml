// Going to the ending sequence
GameEndingRoom = function()
{	
	var TransitionToEndingRoom = function()
	{
		// Reset the textbox
		instance_textbox.Reset();
		// Transition to the ending room
		ChangeRooms(room_ending);
	}
	CreateFader(FadeState.FadeOut, GetDefaultFadingSpeed(), TransitionToEndingRoom);
	
	// Don't give the control to the player while transitioning
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Set that Mimi wasn't caught
	SetMimiCaught(false);
	
	// Freeze at the last frame of the crawl animation when mimi hits the ending trigger
	PlayerPlayAnimation2(anim_mimiCrawlIdle, noone);
}

var endingCollisionContext = new CollisionContext(GetPlayerInstance(), GameEndingRoom);
endingCollisionContext.AddGlobalState1(GlobalGameStates.MimiGetsChased);
endingCollisionContext.ExecuteOnHit();
AddCollisionContext(endingCollisionContext);