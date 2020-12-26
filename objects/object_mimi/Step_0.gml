// Clamp the positions between 0-1
m_position = clamp(m_position, 0.0, 1.0);

// Set the position on the path
path_position = m_position;

// Calculate the topleft origin in world space
// TODO: this expects the origin to be in the bottom-center, make this independent
worldSpaceTopLeftX = x - sprite_get_width(sprite_index)/2;
worldSpaceTopLeftY = y - sprite_get_height(sprite_index);
