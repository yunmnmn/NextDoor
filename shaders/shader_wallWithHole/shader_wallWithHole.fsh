//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_size;
uniform vec2 u_origin;
uniform vec2 u_sizeUv;
uniform float u_scale;
uniform vec4 u_bayerProperties;

uniform sampler2D s_bayer8;

// Takes normalized UV, and returns a normalized bayer matrix values (0 - 1)
float SampleFromBayer(vec2 uv)
{
	vec2 bayerUvSize = vec2(u_bayerProperties.z - u_bayerProperties.x, u_bayerProperties.w - u_bayerProperties.y);
	vec2 bayerUv = vec2(u_bayerProperties.x + (bayerUvSize.x * uv.x), u_bayerProperties.y + (bayerUvSize.y * uv.y));
	vec4 bayerValue = texture2D(s_bayer8, bayerUv);
	return bayerValue.x;
}
	
void main()
{
	// calculte the screenspace pixel
	vec2 curUv = v_vTexcoord - u_origin;
	vec2 normalizedUv = curUv / u_sizeUv;
	vec2 pixel = normalizedUv * u_size * 0.5;
	
	// Calculte the UV
	float u = mod(pixel.x, 8.0) / 8.0;
	float v = mod(pixel.y, 8.0) / 8.0;
	// Sample from the bayer texture
    float dith = SampleFromBayer(vec2(u, v));
	
	float alpha = 0.0;
	if(u_scale <= dith)
	{
		alpha = 1.0;
	}
	else
	{
		alpha = 0.0;
	}
	
	vec4 color = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	color.a = min(color.a, alpha);
    gl_FragColor = color;
}
