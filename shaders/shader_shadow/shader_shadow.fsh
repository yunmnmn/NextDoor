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
uniform vec2 u_shadowMapSize;

void main()
{
	int test[64];
	test[0] = 1; test[1] = 48; test[2] = 12; test[3] = 60; test[4] = 3; test[5] = 51; test[6] = 15; test[7] = 61;
	test[8] = 32; test[9] = 16; test[10] = 44; test[11] = 28; test[12] = 35; test[13] = 19; test[14] = 47; test[15] = 31;
	test[16] = 8; test[17] = 56; test[18] = 4; test[19] = 52; test[20] = 11; test[21] = 59; test[22] = 7; test[23] = 55;
	test[24] = 40; test[25] = 24; test[26] = 36; test[27] = 20; test[28] = 43; test[29] = 27; test[30] = 39; test[31] = 23;
	test[32] = 2; test[33] = 50; test[34] = 14; test[35] = 61; test[36] = 1; test[37] = 49; test[38] = 13; test[39] = 61;
	test[40] = 34; test[41] = 18; test[42] = 46; test[43] = 30; test[44] = 33; test[45] = 17; test[46] = 45; test[47] = 29;
	test[48] = 10; test[49] = 58; test[50] = 6; test[51] = 54; test[52] = 9; test[53] = 57; test[54] = 5; test[55] = 53;
	test[56] = 42; test[57] = 26; test[58] = 38; test[59] = 22; test[60] = 41; test[61] = 25; test[62] = 37; test[63] = 21;	
	
	float shadowMapU = abs(u_shadowMapUvOffsetX - v_shadowMapTexCoord.x);
	vec2 shadowMapUv = vec2(shadowMapU, v_shadowMapTexCoord.y);
	
	vec2 curUv = shadowMapUv - vec2(u_shadowMapUvBounds[0], u_shadowMapUvBounds[1]);
	vec2 uvSize = vec2(u_shadowMapUvBounds[2] - u_shadowMapUvBounds[0], u_shadowMapUvBounds[3] - u_shadowMapUvBounds[1]);
	vec2 normalizedUv = curUv / uvSize;
	vec2 pixel = normalizedUv * u_shadowMapSize;
	
	int xx = int(mod(pixel.x, 8.0));
	int yy = int(mod(pixel.y, 8.0));
	int index = (xx * 8) + yy;
    float dith = float(test[index]) / 64.0;
	
	vec2 onePixelToUv = uvSize / u_shadowMapSize;
	
	float shadowGradient = 1.0;
	float shadowGradient1 = texture2D(s_shadowMapTexture, vec2(shadowMapU, v_shadowMapTexCoord.y)).x;
	float shadowGradient2 = texture2D(s_shadowMapTexture, vec2(shadowMapU + onePixelToUv.x, v_shadowMapTexCoord.y)).x;
	float shadowGradient3 = texture2D(s_shadowMapTexture, vec2(shadowMapU, v_shadowMapTexCoord.y + onePixelToUv.y)).x;
	float shadowGradient4 = texture2D(s_shadowMapTexture, vec2(shadowMapU + onePixelToUv.x, v_shadowMapTexCoord.y + onePixelToUv.y)).x;
	if((shadowGradient1 + shadowGradient2 + shadowGradient3 + shadowGradient4) * 0.25 < dith)
	{
		shadowGradient = 0.7;
	}
	
	// Sample the texture like normal (this is standard from GM)
	vec4 baseColour = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	
	// Only multiply the colour with the shadowgradient, leave the alpha alone
	baseColour.rgb *= shadowGradient;
	
	// Set the fragment color
    gl_FragColor = baseColour;
}