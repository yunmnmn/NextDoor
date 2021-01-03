// All structs used for the textbox
enum TextboxState
{
	Idle,
	RenderingContext,
	Waiting
}

function RenderText(p_textContext)
{
	// Don't render text if it's already rendering something, or if it's registering the space twice
	if(m_state != TextboxState.Idle || m_sameFrame > 0)
	{
		return false;
	}
	// Only allow rendering to the textbox when nothing is being rendered
	//assert_fail(m_state != TextboxState.Idle, "Can't have multiple active rendering textboxes");
	
	m_state = TextboxState.RenderingContext;
	
	m_textContext = p_textContext;
	m_subTextIndex = 0;
	m_playSpeed = 0.0;
	m_text = "";
	
	// HACK: Used to avoid registering the space twice, resulting in skipping the text
	m_sameFrame = 2;
	
	return true;
}

function Reset()
{
	m_state = TextboxState.Idle;
	m_textContext = noone;
	m_subTextIndex = 0;
	m_playSpeed = 0.0;
	m_textPosition = 0.0;
	m_text = "";
	m_sameFrame = 0;
}

// Register this instance to the global textbox instance
RegisterTextboxInstance(id);

// This text is used to render text
m_textContext = noone;
m_state = TextboxState.Idle;

// Used as an index to which part of the string to copy
m_subTextIndex = 0;
m_playSpeed = 0.0;
m_textPosition = 0.0;
m_text = "";

// HACK: to not register the space twice
m_sameFrame = 0;

m_xOffset = x;
