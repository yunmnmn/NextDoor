// All structs used for the textbox
enum TextboxState
{
	Idle,
	RenderingContext
}

// Register this instance to the global textbox instance
RegisterTextboxInstance(id);

function RenderText(p_textContext)
{
	// Only allow rendering to the textbox when nothing is being rendered
	assert_fail(m_state != TextboxState.Idle, "No textbox instance is registered");
	
	m_state = TextboxState.RenderingContext;
	
	m_textContext = p_textContext;
	m_subTextIndex = 0;
	m_playSpeed = 0.0;
	m_text = "";
}

m_state = TextboxState.Idle;

// This text is used to render text
m_textContext = noone;

// Used as an index to which part of the string to copy
m_subTextIndex = 0;
m_playSpeed = 0.0;
m_textPosition = 0.0;
m_text = "";