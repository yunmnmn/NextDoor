// Face Mimi depending on the position on the X axis
if(GetPlayerInstance().x > x)
{
	// TODO: use the mirror function
	image_xscale = -1;
	m_mirrored = true;
}
else
{
	image_xscale = 1;
	m_mirrored = false;
}