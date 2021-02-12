// Set the ShadowMap surface as target
SetShadowMapAsTarget();
shader_set(shader_createShadow);
// Draw the shadowmap
draw_sprite(sprite_index, 1, x, y);

// Reset the shadowmap
ResetShadowMapAsTarget();
shader_reset();
// Draw the normal background
draw_sprite(sprite_index, 0, x, y);