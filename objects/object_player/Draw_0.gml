// Get the background's Sprite from the backgroundObjectIndex
var backgroundSpriteIndex = GetBackgroundSpriteIndex()
var backgroundInstance = GetBackgroundInstance();

// Get the width and height of the background sprite
var backgroundWidth = sprite_get_width(backgroundSpriteIndex);
var backgroundHeight = sprite_get_height(backgroundSpriteIndex);

// Calculate the normalized position of Mimi's topleft relative to the Background
var backgroundWorldPosX = backgroundInstance.x;
var backgroundWorldPosY = backgroundInstance.y;
var normalizedX = (worldSpaceTopLeftX - backgroundWorldPosX) / (backgroundWidth - backgroundWorldPosX);
var normalizedY = (worldSpaceTopLeftY - backgroundWorldPosY) / (backgroundHeight - backgroundWorldPosY);

// Get Mimi's current texture that is used
// sprite_index = sprite handle
// image_index = subimage index
var mimiTexture = sprite_get_texture(sprite_index, image_index);

// Calculate mimi's texel size compared to the ShadowMap (read about texturemap if it's unclear)
var shadowMapTexture = GetShadowMapTexture();
var xRatio = texture_get_texel_width(mimiTexture) / texture_get_texel_width(shadowMapTexture);
var yRatio = texture_get_texel_height(mimiTexture) / texture_get_texel_height(shadowMapTexture);
assert_fail(xRatio != 1, "Ratio must be 1, fix later");
assert_fail(yRatio != 1, "Ratio must be 1, fix later");

// Calculate the image UV data from the sprites
var mimiImageUv = sprite_get_uvs(sprite_index, image_index);
var shadowMapImageUv = sprite_get_uvs(backgroundSpriteIndex, 1); // 1 = shadowmap index

// Set the ShadowMapUv offset depending if Mimi's texture is mirrored
var shadowMapUvOffsetX = 0;
if(m_direction == MimiDirection.Left)
{
	// Calculate the min and max UV to sample from the ShadowMap
	var shadowMapUvWidth = shadowMapImageUv[2] - shadowMapImageUv[0];
	var offsetMin = shadowMapImageUv[0] + (normalizedX * shadowMapUvWidth)
	var offsetMax = shadowMapImageUv[0] + (normalizedX * shadowMapUvWidth) + (mimiImageUv[2] - mimiImageUv[0]);
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
shader_set_uniform_f(shader_get_uniform(shader_shadow, "u_texCoordOrigin"), mimiImageUv[0], mimiImageUv[1]);
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