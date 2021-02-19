SetShadowMapAsTarget();
shader_set(shader_createShadow);

// Draw the shadowmap
draw_sprite_ext( background_mimiRoomDay, 1, x, y, 1.0, 1.0, 0.0, c_white, 1.0 - m_transition);
// Draw the shadowmap
draw_sprite_ext(background_mimiRoomNight, 1, x, y, 1.0, 1.0, 0.0, c_white, m_transition);


// Reset the shadowmap
ResetShadowMapAsTarget();
shader_reset();

// Draw the normal background
draw_sprite_ext( background_mimiRoomDay, 0, x, y, 1.0, 1.0, 0.0, c_white, 1.0 - m_transition);
// Draw the normal background
draw_sprite_ext(background_mimiRoomNight, 0, x, y, 1.0, 1.0, 0.0, c_white, m_transition);