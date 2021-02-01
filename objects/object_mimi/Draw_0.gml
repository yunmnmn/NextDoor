//HACK: direct copy from ParentLighting; due to limited support for parenting

// Calculate the topleft origin in world space
var worldSpaceTopLeftX = x - sprite_get_xoffset(sprite_index);
var worldSpaceTopLeftY = y - sprite_get_yoffset(sprite_index);

// If it's mirrored, 
if(m_mirrored)
{
	// Get the width and height of the background sprite
	var spriteSize = GetSpriteSize(sprite_index);
	worldSpaceTopLeftX = x - (spriteSize.m_x - sprite_get_xoffset(sprite_index));
}

// Get the background's Sprite from the backgroundObjectIndex
var backgroundSpriteIndex = GetBackgroundSpriteIndex();
var backgroundInstance = GetBackgroundInstance();

// Get the width and height of the background sprite
var backgroundSize = GetSpriteSize(backgroundSpriteIndex);

// Calculate the normalized position of Sprite's topleft relative to the Background
var backgroundWorldPosition = GetWorldPosition(backgroundInstance);
var normalizedX = (worldSpaceTopLeftX - backgroundWorldPosition.m_x) / backgroundSize.m_x;
var normalizedY = (worldSpaceTopLeftY - backgroundWorldPosition.m_y) / backgroundSize.m_y;

// Get sprite's current texture that is used
// sprite_index = sprite handle
// image_index = subimage index
var spriteTexture = sprite_get_texture(sprite_index, image_index);

// Calculate Sprite's texel size compared to the ShadowMap (read about texturemap if it's unclear)
var shadowMapTexture = GetShadowMapTexture();
var xRatio = texture_get_texel_width(spriteTexture) / texture_get_texel_width(shadowMapTexture);
var yRatio = texture_get_texel_height(spriteTexture) / texture_get_texel_height(shadowMapTexture);

// Calculate the image UV data from the sprites
var spriteImageUv = sprite_get_uvs(sprite_index, image_index);
var shadowMapImageUv = sprite_get_uvs(backgroundSpriteIndex, 1); // 1 = shadowmap index

// Set the ShadowMapUv offset depending if Sprite's texture is mirrored
var shadowMapUvOffsetX = 0;

// If it's mirrored, set a shadowmap Uv offset ( abs((min + max) - uv) = mirrored values )
if(m_mirrored)
{
	// Calculate the min and max UV to sample from the ShadowMap
	var shadowMapUvWidth = shadowMapImageUv[2] - shadowMapImageUv[0];
	var spriteUvWidth = spriteImageUv[2] - spriteImageUv[0];
	var offsetMin = shadowMapImageUv[0] + (normalizedX * shadowMapUvWidth)
	var offsetMax = shadowMapImageUv[0] + (normalizedX * shadowMapUvWidth) + spriteUvWidth * xRatio;
	shadowMapUvOffsetX = offsetMin + offsetMax;
}

// Set the shader
shader_set(shader_shadow);

// Bind the ShadowMap here
var t_sampler = shader_get_sampler_index(shader_shadow, "s_shadowMapTexture");
texture_set_stage(t_sampler, shadowMapTexture);

// Bind the uniform data
shader_set_uniform_f(shader_get_uniform(shader_shadow, "u_ratio"), normalizedX, normalizedY, xRatio, yRatio );
shader_set_uniform_f(shader_get_uniform(shader_shadow, "u_shadowMapUv"),
						shadowMapImageUv[0], // Left uv
						shadowMapImageUv[1], // Top uv
						shadowMapImageUv[2] - shadowMapImageUv[0],	// UV width
						shadowMapImageUv[3] - shadowMapImageUv[1]);	// UV height
shader_set_uniform_f(shader_get_uniform(shader_shadow, "u_texCoordOrigin"), spriteImageUv[0], spriteImageUv[1]);
shader_set_uniform_f(shader_get_uniform(shader_shadow, "u_shadowMapUvOffsetX"), shadowMapUvOffsetX);
shader_set_uniform_f(shader_get_uniform(shader_shadow, "u_shadowMapUvBounds"),
						shadowMapImageUv[0],  // Left uv
						shadowMapImageUv[1],  // Top uv
						shadowMapImageUv[2],  // Right uv
						shadowMapImageUv[3]); // Bottom uv

// Draw the shader
draw_self();

// Reset the shader
shader_reset();