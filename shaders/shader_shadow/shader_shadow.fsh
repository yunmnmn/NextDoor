//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
// Custom varying
varying vec2 v_shadowMapTexCoord;

uniform sampler2D s_shadowMapTexture;
uniform float u_shadowMapUvOffsetX;

void main()
{
	float shadowMapU = abs(u_shadowMapUvOffsetX - v_shadowMapTexCoord.x);
	float shadowGradient = texture2D(s_shadowMapTexture, vec2(shadowMapU, v_shadowMapTexCoord.y)).x;
	
	// Sample the texture like normal (this is standard from GM)
	vec4 baseColour = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	
	// Only multiply the colour with the shadowgradient, leave the alpha alone
	baseColour.rgb *= shadowGradient;
	
	// Set the fragment color
    gl_FragColor = baseColour;
}