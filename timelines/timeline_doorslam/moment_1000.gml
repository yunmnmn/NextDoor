// If the current TextContext is occupied, go back a second
if(GetControlState() != PlayerControlState.PlayerControl)
{
	timeline_position = timeline_position - 1000;
}
else
{
	// Hide the DoorOpen layer
	instance_doorOpen.visible = false;
	
	// TODO: Play a doorslam sound
	
	// Disable the player control
	SetControlState(PlayerControlState.PlayerNoControl);
	
	// Play the shock animation
	var CallbackWhenShockFinishes = function()
	{
		var MonologueFinished = function()
		{
			// Enable the player control
			SetControlState(PlayerControlState.PlayerControl);
		}
		
		var c16_1 = new TextContext(sprite_mimiAvatarTroubled, true, MonologueFinished);	
		c16_1.AddSubText(new SubText("Must have been the wind.", 0.4, true));
		RenderText(c16_1);
		
		// Back to idle scared
		PlayerPlayAnimation2(sprite_mimiIdleScared, noone);
	}
	PlayerPlayAnimation2(anim_mimiShock, CallbackWhenShockFinishes);
	
	// Play the sound to slam the door
	PlaySoundAt(foley_youngsterRoomDoorSlam, 1590, 220, 400, 2000, 1, false, 10.0);
	
	// Rumble the controller when the door slams
	Rumble(0.9, 200);
}