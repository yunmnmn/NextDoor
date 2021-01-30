m_mirrored = false;

function Mirror(p_mirror)
{
	if(p_mirror)
	{
		m_mirrored = true;
		image_xscale = -1.0;
	}
	else
	{
		m_mirrored = false;
		image_xscale = 1.0;
	}
}