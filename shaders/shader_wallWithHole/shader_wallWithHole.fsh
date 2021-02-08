//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_size;
uniform vec2 u_origin;
uniform vec2 u_sizeUv;
uniform float u_scale;
	
void main()
{
	// Why... GM pls
	// Modified Bayer Matrix to fit fading better
	int test[64];
	test[0] = 1; test[1] = 48; test[2] = 12; test[3] = 60; test[4] = 3; test[5] = 51; test[6] = 15; test[7] = 61;
	test[8] = 32; test[9] = 16; test[10] = 44; test[11] = 28; test[12] = 35; test[13] = 19; test[14] = 47; test[15] = 31;
	test[16] = 8; test[17] = 56; test[18] = 4; test[19] = 52; test[20] = 11; test[21] = 59; test[22] = 7; test[23] = 55;
	test[24] = 40; test[25] = 24; test[26] = 36; test[27] = 20; test[28] = 43; test[29] = 27; test[30] = 39; test[31] = 23;
	test[32] = 2; test[33] = 50; test[34] = 14; test[35] = 61; test[36] = 1; test[37] = 49; test[38] = 13; test[39] = 61;
	test[40] = 34; test[41] = 18; test[42] = 46; test[43] = 30; test[44] = 33; test[45] = 17; test[46] = 45; test[47] = 29;
	test[48] = 10; test[49] = 58; test[50] = 6; test[51] = 54; test[52] = 9; test[53] = 57; test[54] = 5; test[55] = 53;
	test[56] = 42; test[57] = 26; test[58] = 38; test[59] = 22; test[60] = 41; test[61] = 25; test[62] = 37; test[63] = 21;
	
	vec2 curUv = v_vTexcoord - u_origin;
	vec2 normalizedUv = curUv / u_sizeUv;
	vec2 pixel = normalizedUv * u_size * 0.5;
	
	int xx = int(mod(pixel.x, 8.0));
	int yy = int(mod(pixel.y, 8.0));
	int index = (xx * 8) + yy;
    float dith = float(test[index]);
	
	float alpha = 0.0;
	if(u_scale * 64.0 <= dith)
	{
		alpha = 1.0;
	}
	else
	{
		alpha = 0.0;
	}
	
	vec4 color = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	//color.a = ((1.0 - u_scale) * dith) / 64.0;
	color.a = alpha;
    gl_FragColor = color;
}
