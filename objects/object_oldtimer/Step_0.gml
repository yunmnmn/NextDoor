// Face Mimi depending on the position on the X axis
if(GetPlayerInstance().x > x)
{
	image_xscale = 1;
	m_mirrored = false;
}
else
{
	image_xscale = -1;
	m_mirrored = true;
}