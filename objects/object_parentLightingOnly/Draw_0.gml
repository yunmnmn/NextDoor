//HACK: direct copy from ParentLighting; due to limited support for parenting

// Calculate the topleft origin in world space
var worldSpaceTopLeftX = x - sprite_get_xoffset(sprite_index);
var worldSpaceTopLeftY = y - sprite_get_yoffset(sprite_index);

// If it's mirrored, 
if(m_mirrored)
{
	// Get the width and height of the background sprite
	var spriteSizeX = GetSpriteSizeX(sprite_index);
	worldSpaceTopLeftX = x - (spriteSizeX - sprite_get_xoffset(sprite_index));
}

// Calculate the normalized position of Sprite's topleft relative to the ShadowMap
var normalizedPosX = (worldSpaceTopLeftX) / room_width;
var normalizedPosY = (worldSpaceTopLeftY) / room_height;

// Get sprite's current texture that is used
// sprite_index = sprite handle
// image_index = subimage index
var spriteTexture = sprite_get_texture(sprite_index, image_index);

// Calculate Sprite's texel size compared to the ShadowMap (read about texturemap if it's unclear)
var shadowMapTexture = GetShadowMapTexture();
var ratioX =  texture_get_texel_width(shadowMapTexture) / texture_get_texel_width(spriteTexture);
var ratioY = texture_get_texel_height(shadowMapTexture) / texture_get_texel_height(spriteTexture);

// Calculate the image UV data from the sprites
var spriteImageUv = sprite_get_uvs(sprite_index, image_index);

// Set the ShadowMapUv offset depending if Sprite's texture is mirrored
var shadowMapUvOffsetX = 0;

// If it's mirrored, set a shadowmap Uv offset ( abs((min + max) - uv) = mirrored values )
if(m_mirrored)
{
	// Calculate the min and max UV to sample from the ShadowMap
	var shadowMapUvWidth = 1.0;
	var spriteUvWidth = spriteImageUv[2] - spriteImageUv[0];
	var offsetMin = 0 + (normalizedPosX * shadowMapUvWidth)
	var offsetMax = 0 + (normalizedPosX * shadowMapUvWidth) + spriteUvWidth * ratioX;
	shadowMapUvOffsetX = offsetMin + offsetMax;
}

// Set the shader
shader_set(shader_shadow);

// Bind the ShadowMap here
var t_sampler = shader_get_sampler_index(shader_shadow, "s_shadowMapTexture");
texture_set_stage(t_sampler, shadowMapTexture);

// Bind the uniform data
shader_set_uniform_f(shader_get_uniform(shader_shadow, "u_ratio"), ratioX, ratioY);
shader_set_uniform_f(shader_get_uniform(shader_shadow, "u_norm"), normalizedPosX, normalizedPosY);
shader_set_uniform_f(shader_get_uniform(shader_shadow, "u_texCoordOrigin"), spriteImageUv[0], spriteImageUv[1]);
shader_set_uniform_f(shader_get_uniform(shader_shadow, "u_shadowMapUvOffsetX"), shadowMapUvOffsetX);

// Draw the shader with the sprite
draw_self();

// Reset the shader to the default one
shader_reset();