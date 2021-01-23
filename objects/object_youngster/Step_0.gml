// Face Mimi depending on the position on the X axis
if(GetPlayerInstance().x > x)
{
	// If Mimi is on the right side, mirror Youngster (Default is looking left)
	image_xscale = -1;
	m_mirrored = true;
}
else
{
	image_xscale = 1;
	m_mirrored = false;
}