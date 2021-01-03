// Fade into the level
CreateFader(FadeState.FadeIn, 0.01, noone);

// Set the id of the background in the global
RegisterBackgroundInstance(id);

// Don't give the control to the player at the beginning
SetControlState(PlayerControlState.PlayerControl);

// Set Mimi on the path
PlayerSetPath(path_hallwayDown, 0.0);

// Set up the viewport
m_viewport = view_camera[0];
m_viewportHalfWidth = camera_get_view_width(m_viewport) * 0.5;
