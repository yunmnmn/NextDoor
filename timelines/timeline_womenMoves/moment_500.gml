// Play the sound that the door is opening in the hallway
PlaySound(foley_hallwayDoorOpenDistance, 10.0, false);

// Add the hallway footsteps to the women
instance_youngsetRoomWomenOutside.AddHallwayWalkingSounds();

// Set the path for the women to walk to the window
instance_youngsetRoomWomenOutside.SetPath(path_youngsterRoomWomenFootsteps, 0.0, 1.0);
// Play the walking animation
instance_youngsetRoomWomenOutside.PlayAnimation(anim_womenWalkHallwayProxy, false, noone);

function StopWalkingInHallway()
{
	// Reset the textbox
	instance_youngsetRoomWomenOutside.image_speed = 0.0;
	instance_youngsetRoomWomenOutside.path_speed = 0.0;
	
	conversationFinished = function()
	{
		SetControlState(PlayerControlState.PlayerControl);
		SetGlobalGameState(GlobalGameStates.MimiHearsTickingAtWindow);
	}

	var c25_1 = new TextContext(sprite_mimiAvatarTroubled, true, conversationFinished);
	c25_1.AddSubText(new SubText("Did she leave?", 0.3, true));
	RenderText(c25_1);

	// Disable the player control
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Play the idle animation
	PlayerPlayAnimation2(sprite_mimiIdleScared, noone);
}
// Set the callback to play the Movie when the women reaches the end of the path
instance_youngsetRoomWomenOutside.AddPathPointCallback(4, StopWalkingInHallway, false);