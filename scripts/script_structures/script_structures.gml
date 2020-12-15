// Define a Vector2 class
function Vector2(p_x, p_y) constructor
{
	m_x = p_x;
	m_y = p_y;
	
	Add = function(p_other)
	{
        m_x += p_other.m_x;
        m_y += p_other.m_y;
    }
}

// SubTextContext is used 
function SubText(p_text, p_playSpeed) constructor
{
	m_text = p_text;
	m_playSpeed = p_playSpeed;
}

// TextContext is used 
function TextContext(p_avatarSpriteIndex, p_callback) constructor
{
	m_avatarSpriteIndex = p_avatarSpriteIndex;
	m_callback = p_callback;
	m_subTexts = ds_list_create();
	
	AddSubText = function(p_subText)
	{
		ds_list_add(m_subTexts, p_subText);
	}
}

