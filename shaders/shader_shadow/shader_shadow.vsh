//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

// Uniforms
uniform vec4 u_ratio;
uniform vec4 u_shadowMapUv;
uniform vec2 u_texCoordOrigin;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
// Custom varyings
varying vec2 v_shadowMapTexCoord;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
	
	// (ShadowMap UV in TextureMapSpace) + Offset of sprites position in uv cordinate space + offset of the uv vertex (multiplied with the ratio of uv difference of the sprite and background)
	v_shadowMapTexCoord =	u_shadowMapUv.xy + 
							vec2(u_ratio.x * u_shadowMapUv.z, u_ratio.y * u_shadowMapUv.w) + 
							((in_TextureCoord - u_texCoordOrigin) * u_ratio.zw);
}
