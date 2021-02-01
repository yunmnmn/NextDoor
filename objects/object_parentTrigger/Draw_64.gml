// NOTE: This is in screen space. Convert from room space -> screen space
if(m_drawButtonPrompt)
{
	draw_sprite(anim_buttonSpace, m_drawFrame, x - camera_get_view_x(view_camera[0]), y - camera_get_view_y(view_camera[0]));
}