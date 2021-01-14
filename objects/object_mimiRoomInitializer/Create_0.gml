// At the very first state, play an animation first, and set the player at the start of the path
if(GetGlobalGameState() == GlobalGameStates.MimiRoomSits)
{
	// HACK: one time thing
	global.m_path = path_mimiRoom;
	
	// Don't give the control to the player at the beginning
	SetControlState(PlayerControlState.PlayerNoControl);

	// Set Mimi on the path
	PlayerSetPath(path_mimiRoom, 0.0);
	
	// When the animation is finished playing, call this callback funciton
	{
		// This callback will be executed when the animation is finished with executing
		var animationEndCallback = function()
		{
			PlayerPlayAnimation(sprite_mimiIdle, noone);
			SetControlState(PlayerControlState.PlayerControl);
			
			// Set the next global state after the animation is finished playing
			SetGlobalGameState(GlobalGameStates.MimiGoingToYoungster);
		}

		// Play the sitting animation at the start of the level
		PlayerPlayAnimation(anim_mimiSit, animationEndCallback);
	}
}