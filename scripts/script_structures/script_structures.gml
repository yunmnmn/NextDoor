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
function SubText(p_text, p_playSpeed, p_newLine) constructor
{
	m_text = p_text;
	m_playSpeed = p_playSpeed;
	m_newLine= p_newLine;
}

// TextContext is used to chain texts
function TextContext(p_avatarSpriteIndex, p_skippable, p_callback) constructor
{
	m_avatarSpriteIndex = p_avatarSpriteIndex;
	m_callback = p_callback;
	m_subTexts = ds_list_create();
	m_skippable = p_skippable;
	m_progressable = true;
	m_animationCallback = noone;
	m_avatarYOffset = 0;
	
	m_avatarImageSpeed = 1000;
	
	AddSubText = function(p_subText)
	{
		ds_list_add(m_subTexts, p_subText);
		
		if(m_avatarSpriteIndex != noone)
		{
			m_avatarImageSpeed = sprite_get_speed(m_avatarSpriteIndex);
		}
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

function CollisionContext(p_collisionInstance, p_callback) constructor
{
	m_collisionInstance = p_collisionInstance;
	m_callback = p_callback;
	
	m_globalStates = ds_list_create();
	
	m_allStates = false;
	m_executeOnHit = false;
	m_persistant = false;
	m_doNotExecuteOn = false;
	
	AddGlobalState1 = function(p_globalState1)
	{
		ds_list_add(m_globalStates, p_globalState1);
	}
	
	AddGlobalState2 = function(p_globalState1, p_globalState2)
	{
		AddGlobalState1(p_globalState1);
		ds_list_add(m_globalStates, p_globalState2);
	}

	AddGlobalState3 = function(p_globalState1, p_globalState2, p_globalState3)
	{
		AddGlobalState2(p_globalState1, p_globalState2);
		ds_list_add(m_globalStates, p_globalState3);
	}
	
	AddGlobalState4 = function(p_globalState1, p_globalState2, p_globalState3, p_globalState4)
	{
		AddGlobalState3(p_globalState1, p_globalState2, p_globalState3);
		ds_list_add(m_globalStates, p_globalState4);
	}
	
	AddGlobalState5 = function(p_globalState1, p_globalState2, p_globalState3, p_globalState4, p_globalState5)
	{
		AddGlobalState4(p_globalState1, p_globalState2, p_globalState3, p_globalState4);
		ds_list_add(m_globalStates, p_globalState5);
	}	
	
	AllStates = function()
	{
		m_allStates = true;
	}
	
	ExecuteOnHit = function()
	{
		m_executeOnHit = true;
	}
}

