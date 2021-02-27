if(m_drawButtonPrompt)
{
	var player = GetPlayerInstance();
	// NOTE: This is in screen space. Convert from room space -> screen space
	draw_sprite(m_markSpriteIndex, m_drawFrame, player.x - camera_get_view_x(view_camera[0]), player.y - player.sprite_height - camera_get_view_y(view_camera[0]));
}