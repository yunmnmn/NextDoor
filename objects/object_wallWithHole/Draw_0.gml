var spriteImageUv = sprite_get_uvs(sprite_index, image_index);

var spriteUvWidth = spriteImageUv[2] - spriteImageUv[0];
var spriteUvHeight = spriteImageUv[3] - spriteImageUv[1];

var topX = spriteImageUv[0];
var topY = spriteImageUv[1];

var spriteWidth = sprite_width;
var spriteHeight = sprite_height;

var bayerUvs = sprite_get_uvs(sprite_bayer, 0);

// Set the shader
shader_set(shader_wallWithHole);

// Set the bayer texture
var bayerTexture = sprite_get_texture(sprite_bayer, 0);
var t_bayerSampler = shader_get_sampler_index(shader_wallWithHole, "s_bayer8");
texture_set_stage(t_bayerSampler, bayerTexture);

// Bind the uniform data
shader_set_uniform_f(shader_get_uniform(shader_wallWithHole, "u_bayerProperties"),
						bayerUvs[0],
						bayerUvs[1],
						bayerUvs[2],
						bayerUvs[3]);
shader_set_uniform_f(shader_get_uniform(shader_wallWithHole, "u_size"),
						spriteWidth,
						spriteHeight);
shader_set_uniform_f(shader_get_uniform(shader_wallWithHole, "u_origin"),
						topX, // Left uv
						topY); // Top uv
shader_set_uniform_f(shader_get_uniform(shader_wallWithHole, "u_sizeUv"),
						spriteUvWidth,
						spriteUvHeight); 
shader_set_uniform_f(shader_get_uniform(shader_wallWithHole, "u_scale"),
						m_scalar);
						

// Draw the shader
draw_self();

// Reset the shader
shader_reset();