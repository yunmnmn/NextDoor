// NOTE: This is in screen space. Convert from room space -> screen space
if(m_drawButtonPrompt)
{
	var player = GetPlayerInstance();
	draw_sprite(anim_mark, m_drawFrame, player.x, player.y - player.sprite_height - camera_get_view_y(view_camera[0]));
}