// Get the player
var player = GetPlayerInstance();

var followX = clamp(player.x, m_viewportHalfWidth, room_width - m_viewportHalfWidth);

camera_set_view_pos(m_viewport, followX - m_viewportHalfWidth, 0);
