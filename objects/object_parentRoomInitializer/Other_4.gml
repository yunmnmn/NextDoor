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

// --------- ScreenShake code ---------

function PulseScreen(p_magnitude)
{
	m_initialShakeMagnitude = p_magnitude;
	m_shakeMagnitude = p_magnitude;
	m_stabilized = 0;
}

// --------- EntryPoint code ---------

// Set the id of the background in the global
RegisterBackgroundInstance(id);

// Fade into the level
CreateFader(FadeState.FadeIn, 0.01, noone);

// Set up the viewport
m_viewport = view_camera[0];
m_viewportHalfSize = new Vector2(camera_get_view_width(m_viewport) * 0.5, camera_get_view_height(m_viewport) * 0.5);

// By defualt, follow the player
m_followInstance = GetPlayerInstance();
// By default, the follow speed is instant
m_followSpeed = 1.0;

m_viewportMinX = 0.0;
m_viewportMaxX = room_width;
m_viewportMinY = 0.0;
m_viewportMaxY = room_height;

m_initialShakeMagnitude = 0.0;
m_shakeMagnitude = 0.0;
m_stabilized = 1.0;
m_stabilizeSpeed = 0.0005;

m_rawPositionX = 0.0;
m_rawPositionY = 0.0;

// Call the PostRoomLoad function, might be set from other systems (e.g ChangeRoomAndSetPath())
ExecutePostRoomLoadCallbacks();