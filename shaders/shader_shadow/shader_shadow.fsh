//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

varying vec2 v_shadowMapTexCoord;

uniform sampler2D shadowMapTexture;

void main()
{
	float shadowGradient = texture2D(shadowMapTexture, v_shadowMapTexCoord).x;
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	gl_FragColor.xyz *= shadowGradient;
}