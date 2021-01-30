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

// TextContext is used to chain texts
function TextContext(p_avatarSpriteIndex, p_skippable, p_callback) constructor
{
	m_avatarSpriteIndex = p_avatarSpriteIndex;
	m_callback = p_callback;
	m_subTexts = ds_list_create();
	m_skippable = p_skippable;
	m_progressable = true;
	
	AddSubText = function(p_subText)
	{
		ds_list_add(m_subTexts, p_subText);
	}
}

enum PathCallbackType
{
	LowToHigh,
	HighToLow,
	Both,
}

function PathCallback(p_pathIndex, p_position, p_callback, p_persistant, p_callbackType) constructor
{
	m_pathIndex = p_pathIndex;
	m_position = p_position;
	m_callback = p_callback;
	m_persistant = p_persistant;
	m_callbackType = p_callbackType;
}

