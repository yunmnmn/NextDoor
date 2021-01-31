// Set the id of the background in the global
RegisterBackgroundInstance(id);

// Fade into the level
CreateFader(FadeState.FadeIn, 0.01, noone);

// Set up the viewport
m_viewport = view_camera[0];
m_viewportHalfSize = new Vector2(camera_get_view_width(m_viewport) * 0.5, camera_get_view_height(m_viewport) * 0.5);

// By defualt, follow the player
m_followInstance = GetPlayerInstance();
// By default, the follow speed is instant
m_followSpeed = 1.0;

// Call the PostRoomLoad function, might be set from other systems (e.g ChangeRoomAndSetPath())
ExecutePostRoomLoadCallbacks();