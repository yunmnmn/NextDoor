//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
// Custom varying
varying vec2 v_shadowMapTexCoord;

uniform sampler2D s_shadowMapTexture;
uniform float u_shadowMapUvOffsetX;
uniform vec4 u_shadowMapUvBounds;

void main()
{
	float shadowGradient = 1.0;
	// Only calculate the gradient is within 0-1, and only if it's within the bounds of the ShadowMap's UV
	// This is only necessary for sprites that need to be mirrored
	if(v_shadowMapTexCoord.x > 0.0 && v_shadowMapTexCoord.x < 1.0 &&
		v_shadowMapTexCoord.x > u_shadowMapUvBounds.x && v_shadowMapTexCoord.x < u_shadowMapUvBounds.z &&
		v_shadowMapTexCoord.y > u_shadowMapUvBounds.y && v_shadowMapTexCoord.y < u_shadowMapUvBounds.w)
	{
		float shadowMapU = abs(u_shadowMapUvOffsetX - v_shadowMapTexCoord.x);
		shadowGradient = texture2D(s_shadowMapTexture, vec2(shadowMapU, v_shadowMapTexCoord.y)).x;
	}
	
	// Sample the texture like normal (this is standard from GM)
	vec4 baseColour = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	
	// Only multiply the colour with the shadowgradient, leave the alpha alone
	baseColour.rgb *= shadowGradient;
	
	// Set the fragment color
    gl_FragColor = baseColour;
}