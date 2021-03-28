function RestrictViewportX(p_min, p_max)
{
	var minn = clamp(p_min, 0, room_width);
	var maxx = clamp(p_max, 0, room_width);
	
	assert(minn <= maxx, "Min can't be bigger than max")

	m_viewportMinX = minn;
	m_viewportMaxX = maxx;
}

function RestrictViewportY(p_min, p_max)
{
	var minn = clamp(p_min, 0, room_height);
	var maxx = clamp(p_max, 0, room_height);
	
	assert(minn <= maxx, "Min can't be bigger than max")

	m_viewportMinY = minn;
	m_viewportMaxY = maxx;
}

function SetViewportPositionX(p_positionX)
{
	var positionY = GetViewportPositionY();
	camera_set_view_pos(m_viewport, p_positionX, positionY);
	m_rawPositionX = p_positionX;
}

function SetViewportPositionY(p_positionY)
{
	var positionX = GetViewportPositionX();
	camera_set_view_pos(m_viewport, positionX, p_positionY);
	m_rawPositionY = p_positionY;
}

function SetViewportPosition(p_positionX, p_positionY)
{
	camera_set_view_pos(m_viewport, p_positionX, p_positionY);
	m_rawPositionX = p_positionX;
	m_rawPositionY = p_positionY;
}

function GetViewportPositionX()
{
	return camera_get_view_x(m_viewport);
}

function GetViewportPositionY()
{
	return camera_get_view_y(m_viewport);
}

function GetViewportWidth()
{
	return camera_get_view_width(m_viewport);
}

function GetViewportHeight()
{
	return camera_get_view_height(m_viewport);
}

function SetViewportFollowInstance(p_instance)
{
	m_pan = 0.0;
	
	if(m_fromPosition != noone)
	{
		delete m_fromPosition;
		m_fromPosition = noone;
	}
	m_fromPosition = new Vector2(GetViewportPositionX(), GetViewportPositionY());
	
	m_followInstance = p_instance;
	ds_list_clear(m_viewportCallbacks);
}

function FollowPosition(p_position)
{
	m_pan = 0.0;

	if(m_fromPosition != noone)
	{
		delete m_fromPosition;
		m_fromPosition = noone;
	}
	m_fromPosition = new Vector2(GetViewportPositionX(), GetViewportPositionY());
	
	DisableFollowingInstance();
	
	if(m_followPosition != noone)
	{
		delete m_followPosition;
		m_followPosition = noone;
	}
	m_followPosition = p_position;
}

function DisableFollowingInstance()
{
	m_followInstance = noone;
}

function DisableFollowingPosition()
{
	m_followPosition = noone
}

function AddViewportFollowCallback(p_callback)
{
	ds_list_add(m_viewportCallbacks, p_callback);
}

function FollowAndDisableInstance(p_instance)
{
	SetViewportFollowInstance(p_instance);
	followCallback = function()
	{
		SetViewportPosition(m_desiredX, m_desiredY);
		DisableFollowingInstance();
	}
	AddViewportFollowCallback(followCallback);
}

function FollowPositionAndDisable(p_position)
{
	FollowPosition(p_position);
	followCallback = function()
	{
		SetViewportPosition(m_desiredX, m_desiredY);
		DisableFollowingPosition();
	}
	AddViewportFollowCallback(followCallback);
}

function FollowInstanceAndCallback(p_instance, p_callback)
{
	SetViewportFollowInstance(p_instance);
	AddViewportFollowCallback(p_callback);
}

function FollowPositionAndCallback(p_position, p_callback)
{
	FollowPosition(p_position);
	AddViewportFollowCallback(p_callback);
}

// --------- ScreenShake code ---------

function PulseScreen(p_magnitude)
{
	m_initialShakeMagnitude = p_magnitude;
	m_shakeMagnitude = p_magnitude;
	m_stabilized = 0;
}

// --------- EntryPoint code ---------

m_followPosition = noone;
m_fromPosition = noone;

// Set the id of the background in the global
RegisterBackgroundInstance(id);

// Fade into the level
m_fader = CreateFader(FadeState.FadeIn, GetDefaultFadingSpeed(), noone);

// Set up the viewport
m_viewport = view_camera[0];
m_viewportHalfSize = new Vector2(GetViewportWidth() * 0.5, GetViewportHeight() * 0.5);
m_viewportCallbacks = ds_list_create();

// By defualt, follow the player
SetViewportFollowInstance(GetPlayerInstance());
// Also able to follow a position

m_pan = 0.0;

// By default, the follow speed is instant
m_followSpeed = 1.0;

m_viewportMinX = 0.0;
m_viewportMaxX = room_width;
m_viewportMinY = 0.0;
m_viewportMaxY = room_height;

m_initialShakeMagnitude = 0.0;
m_shakeMagnitude = 0.0;
m_stabilized = 1.0;
m_stabilizeSpeed = 0.0015;

m_rawPositionX = 0.0;
m_rawPositionY = 0.0;

m_desiredX = 0.0;
m_desiredY = 0.0;

// Call the PostRoomLoad function, might be set from other systems (e.g ChangeRoomAndSetPath())
ExecutePostRoomLoadCallbacks(id);