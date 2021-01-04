// Calculate the topleft origin in world space
// TODO: this expects the origin to be in the bottom-center, make this independent
worldSpaceTopLeftX = x - (sprite_get_width(sprite_index) / 2);
worldSpaceTopLeftY = y - sprite_get_height(sprite_index);