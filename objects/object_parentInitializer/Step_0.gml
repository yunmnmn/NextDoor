// Get the player instance
var player = GetPlayerInstance()

// Calculate the viewport position depending on the viewport and position of Mimi
var followX = clamp(player.x, m_viewportHalfSize.m_x, room_width - m_viewportHalfSize.m_x);
var followY = clamp(player.y, m_viewportHalfSize.m_y, room_height - m_viewportHalfSize.m_y);
camera_set_view_pos(m_viewport, followX - m_viewportHalfSize.m_x, followY - m_viewportHalfSize.m_y);
