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

function SetViewportPositionX(m_positionX)
{
	var positionY = GetViewportPositionY();
	camera_set_view_pos(m_viewport, m_positionX, positionY);
}

function GetViewportPositionX()
{
	return camera_get_view_x(m_viewport);
}

function GetViewportPositionY()
{
	return camera_get_view_y(m_viewport);
}

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

// Call the PostRoomLoad function, might be set from other systems (e.g ChangeRoomAndSetPath())
ExecutePostRoomLoadCallbacks();