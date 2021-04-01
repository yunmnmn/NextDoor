function Rumble(p_intensity, p_miliseconds)
{
	// Only enable rumble for non-html builds
	if(!HtmlMode())
	{
		instance_global.Rumble(p_intensity, p_miliseconds);
	}
}

function StopRumble()
{
	// Only enable rumble for non-html builds
	if(!HtmlMode())
	{
		instance_global.StopRumble();
	}
}