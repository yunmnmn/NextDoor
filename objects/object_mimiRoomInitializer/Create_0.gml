/// @description Insert description here
// You can write your code in this editor

// Set the id of the background in the global
RegisterBackgroundInstance(id);

// Fade into the level
CreateFader(FadeState.FadeIn, 0.01, noone);

// Don't give the control to the player at the beginning
SetControlState(PlayerControlState.PlayerNoControl);

// Set Mimi on the path
PlayerSetPath(path_mimiRoom, 0.0);

// When the animation is finished playing, call this callback funciton
var animationEndCallback = function()
{
	PlayerPlayAnimation(sprite_mimiIdle, noone);
	SetControlState(PlayerControlState.PlayerControl);
}

// Play the sitting animation at the start of the level
PlayerPlayAnimation(anim_mimiSit, animationEndCallback);