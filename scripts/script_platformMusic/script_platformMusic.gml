function IsSafari()
{
	return os_browser == browser_safari;
}

// TODO: do this cleaner
function GetMetal()
{
	if(HtmlMode())
	{
		if(IsSafari())
		{
			return music_metal;
		}
		else	// All other browsers
		{
			return music_metalStreamed;
		}
	}
	else	// PC
	{
		return music_metal;
	}
}

function GetMetalMimiRoom()
{
	if(HtmlMode())
	{
		if(IsSafari())
		{
			return music_metalMimiRoom;
		}
		else	// All other browsers
		{
			return music_metalMimiRoomStreamed;
		}
	}
	else	// PC
	{
		return music_metalMimiRoom;
	}
}

function GetMetalHallway()
{
	if(HtmlMode())
	{
		if(IsSafari())
		{
			return music_metalHallway;
		}
		else	// All other browsers
		{
			return music_metalHallwayStreamed;
		}
	}
	else	// PC
	{
		return music_metalHallway;
	}
}

function GetAmbientScary()
{
	if(HtmlMode())
	{
		if(IsSafari())
		{
			return music_ambientScary;
		}
		else	// All other browsers
		{
			return music_ambientScaryStreamed;
		}
	}
	else	// PC
	{
		return music_ambientScary;
	}
}

function GetAmbientOutside()
{
	if(HtmlMode())
	{
		if(IsSafari())
		{
			return music_ambientOutside;
		}
		else	// All other browsers
		{
			return music_ambientOutsideStreamed;
		}
	}
	else	// PC
	{
		return music_ambientOutside;
	}
}

function GetCicade()
{
	if(HtmlMode())
	{
		if(IsSafari())
		{
			return music_cicade;
		}
		else	// All other browsers
		{
			return music_cicadeStreamed;
		}
	}
	else	// PC
	{
		return music_cicade;
	}
}

function GetChase()
{
	if(HtmlMode())
	{
		if(IsSafari())
		{
			return music_chase;
		}
		else	// All other browsers
		{
			return music_chaseStreamed;
		}
	}
	else	// PC
	{
		return music_chase;
	}
}