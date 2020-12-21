// Don't give the control to the player at the beginning
SetControlState(PlayerControlState.PlayerControl);

// Set Mimi on the path
PlayerSetPath(path_hallDown);

// Set up the viewport
m_viewport = view_camera[0];

m_viewportHalfWidth = camera_get_view_width(m_viewport) * 0.5;


// When the animation is finished playing, call this callback funciton
//var animationEndCallback = function()
//{
//	PlayerPlayAnimation(sprite_mimiIdle, noone);
//	SetControlState(PlayerControlState.PlayerControl);
//}

//// Play the sitting animation at the start of the level
//PlayerPlayAnimation(anim_mimiSit, animationEndCallback);