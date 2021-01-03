// Get the player instance
var player = GetPlayerInstance()

// Calculate the viewport position depending on the viewport and position of Mimi
var followX = clamp(player.x, m_viewportHalfWidth, room_width - m_viewportHalfWidth);
camera_set_view_pos(m_viewport, followX - m_viewportHalfWidth, 0);
