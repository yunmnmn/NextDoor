//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	//if(v_vTexcoord.x > 0.5)
	//{
	//	gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
	//}
	//else
	//{
	//	gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
	//}
}