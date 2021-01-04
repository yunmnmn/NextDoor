// Set the id of the background in the global
RegisterBackgroundInstance(id);

// Don't give the control to the player at the beginning
SetControlState(PlayerControlState.PlayerControl);

// Fade into the level
CreateFader(FadeState.FadeIn, 0.01, noone);

// Set up the viewport
m_viewport = view_camera[0];
m_viewportHalfSize = new Vector2(camera_get_view_width(m_viewport) * 0.5, camera_get_view_height(m_viewport) * 0.5);
