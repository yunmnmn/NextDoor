// Get the background's Sprite from the backgroundObjectIndex
var backgroundSpriteIndex = GetBackgroundSpriteIndex()

// Get the width and height of the background sprite
var backgroundWidth = sprite_get_width(backgroundSpriteIndex);
var backgroundHeight = sprite_get_height(backgroundSpriteIndex);

// Calculate the normalized position of Mimi's topleft relative to the Background
var backgroundWorldPosX = backgroundSpriteIndex.x;
var backgroundWorldPosY = backgroundSpriteIndex.y;
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

// Calculate the image UV data from the sprites
var mimiImageUv = sprite_get_uvs(sprite_index, image_index);
var shadowMapImageUv = sprite_get_uvs(backgroundSpriteIndex, 1); // 1 = shadowmap index

// Set the shader
shader_set(shader_shadow);

// Bind the ShadowMap here
var t_sampler = shader_get_sampler_index(shader_shadow, "shadowMapTexture");
texture_set_stage(t_sampler, shadowMapTexture);

// Bind the uniform data
shader_set_uniform_f( shader_get_uniform(shader_shadow, "u_ratio"), normalizedX, normalizedY, xRatio, yRatio );
shader_set_uniform_f( shader_get_uniform(shader_shadow, "u_shadowMapUv"),
						shadowMapImageUv[0], // Left uv
						shadowMapImageUv[1], // Top uv
						shadowMapImageUv[2] - shadowMapImageUv[0],	// UV width
						shadowMapImageUv[3] - shadowMapImageUv[1]);	// UV height
shader_set_uniform_f( shader_get_uniform(shader_shadow, "u_texCoordOrigin" ), mimiImageUv[0], mimiImageUv[1]);



draw_self();

shader_reset();