enum FadeState
{
	FadeIn,
	FadeOut
}

// Set the fade state
function SetFadeState(p_fadeState)
{
	m_fadeState = p_fadeState;
	if(p_fadeState == FadeState.FadeIn)
	{
		m_alpha = 1.0;
	}
	else if(p_fadeState == FadeState.FadeOut)
	{
		m_alpha = 0.0;
	}
	else
	{
		assert(false, "Invalid fading state");
	}
}

// Set the speed of fading
function SetFadingSpeed(p_fadeSpeed)
{
	m_fadeSpeed = p_fadeSpeed;
}

// Set callback when fading is finished
function SetCallback(p_callback)
{
	m_callback = p_callback;
}

// Set the fading color
function SetFadeColor(p_fadeColor)
{
	// TODO:
}

// Set the default variables
m_fadeSpeed = 0.0;
m_callback = noone;
m_fadeState = FadeState.FadeIn;
m_alpha = 0.0;

// Added later
m_deleteAutomatically = true;
m_overTextbox = false;

m_dirty = false;