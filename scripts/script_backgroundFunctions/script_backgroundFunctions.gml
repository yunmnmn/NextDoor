/*
Some weird ass lingo for texture, sprites, texturemaps, object, instances blabla

object: acts as a template, in which instances can be created from. Objects can have references to
components(sprites, script, sounds, etc)

instances: data copy representative of an object's data and components. Each single instance is a hard-copy
meaning that changing an instance, won't change any other instances made from the object

texturemaps: GameMaker allocates images on texturemaps, instead of allocating each texture as its
resource. This means that GM allocates a really big texture, and suballocates small textures on it. 
This is probably due to optimizations (less binding information to shader etc)

image: Resource that refernces a piece of image from the texturemaps, and some meta data

sprite: Resource that references 1 or multiple textures. GM calls them subimages now... very confusing
*/

// Sets the backgroundInstance, this must be called once per level by the background instance
function RegisterBackgroundInstance(p_instance)
{
	// Check if the background instance is 0 first
	assert(global.g_backgroundInstance == noone, "backgroundInstance variable should be initialized by the object_global to 0 first. Make sure that object_global is initialized first in the room order");
	
	// Check if the background instance's sprite has two frames (0 = background, 1 = shadowmap)
	var backgroundSpriteIndex = object_get_sprite(p_instance.object_index);
	var backgroundSpriteImageCount = sprite_get_number(backgroundSpriteIndex);
	assert(backgroundSpriteImageCount == 2, "The sprite needs to have 2 images, 0 = background, and 1 = shadowmap.");
	
	global.g_backgroundInstance = p_instance;
}

function GetBackgroundInstance()
{
	// Check if the background instance is valid
	assert(global.g_backgroundInstance != noone, "backgroundInstance variable should be initialized by the object_global to 0 first");
	
	return global.g_backgroundInstance;
}

// Resets the backgroundInstance
function ResetBackgroundInstance()
{
	global.g_backgroundInstance = noone;
}

// Returns the BackgroundSpriteIndex
function GetBackgroundSpriteIndex()
{
	assert(global.g_backgroundInstance != noone, "backgroundInstance cannot be 0");
	
	var backgroundSpriteIndex = GetBackgroundInstance().sprite_index;
	assert(backgroundSpriteIndex != -1, "This shouldn't be -1, this means that the object did not have a sprite assigned to it");
	
	return backgroundSpriteIndex;
}

// Returns the Background texture (the one the player sees)
function GetBackgroundTexture()
{
	assert(global.g_backgroundInstance != noone, "backgroundInstance cannot be 0");
	var backgroundTexture = sprite_get_texture(GetBackgroundSpriteIndex(), 0);
	return backgroundTexture;
}

function SetBackgroundSpriteIndex(p_spriteIndex)
{
	GetBackgroundInstance().sprite_index = p_spriteIndex;
}

// -------------- Shadow Map functions --------------

// Sets the ShadowMap surface
function SetShadowMapSurfaceInstance(p_instance)
{
	assert(p_instance != noone, "Surface instance is invalid");
	global.m_shadowSurfaceInstance = p_instance;
}

// Gets the ShadowMap surface
function GetShadowSurfaceInstance()
{
	assert(global.m_shadowSurfaceInstance != noone, "Surface instance is invalid");
	return global.m_shadowSurfaceInstance;
}

// Sets the surface to draw on
function SetShadowMapAsTarget()
{
	var shadowMapSurface = GetShadowSurfaceInstance();
	surface_set_target(shadowMapSurface);
}

// Returns the ShadowMap texture
function GetShadowMapTexture()
{
	var shadowMapSurfaceInstance = GetShadowSurfaceInstance();
	return surface_get_texture(shadowMapSurfaceInstance);
}

// Resets the ShadowMap surface to draw on
function ResetShadowMapAsTarget()
{
	surface_reset_target();
}

//function ResizeShadowMapSurface(p_width, p_width)
//{
//	var shadowSurfaceInstance = GetShadowSurfaceInstance();
//	surface_resize(shadowSurfaceInstance, p_width, p_width);
//}

// -------------- Viewport functions --------------

// Set the instance that the viewport follows
function SetViewportFollowInstance(p_instance)
{
	assert(p_instance != noone, "Instance can't be invalid");
	GetBackgroundInstance().SetViewportFollowInstance(p_instance);
}

function FollowPosition(p_position)
{
	assert(p_position != noone, "p_position must be of type Vector2");
	GetBackgroundInstance().FollowPosition(p_position);
}

// Set the following speed
function SetViewportFollowSpeed(p_followSpeed)
{
	GetBackgroundInstance().m_followSpeed = p_followSpeed;
}

function FollowPositionAndDisable(p_position)
{
	assert(p_position != noone, "p_position must be of type Vector2");
	GetBackgroundInstance().FollowPositionAndDisable(p_position);
}

function FollowAndDisableInstance(p_instance)
{
	assert(p_instance != noone, "p_instance can't be invalid");
	GetBackgroundInstance().FollowAndDisableInstance(p_instance);
}

function AddViewportFollowCallback(p_callback)
{
	assert(p_callback != noone, "p_callback can't be invalid");
	GetBackgroundInstance().AddViewportFollowCallback(p_callback);
}

function DisableFollowingInstance()
{
	GetBackgroundInstance().DisableFollowingInstance();
}

function DisableFollowingPosition()
{
	GetBackgroundInstance().DisableFollowingPosition();
}

function RescrictViewportX(p_min, p_max)
{
	GetBackgroundInstance().RestrictViewportX(p_min, p_max);
}

function RescrictViewportY(p_min, p_max)
{
	GetBackgroundInstance().RestrictViewportY(p_min, p_max);
}

function UnrestrictViewportX()
{
	GetBackgroundInstance().RestrictViewportX(0, 99999999);
}

function UnrestrictViewportY()
{
	GetBackgroundInstance().RestrictViewportY(0, 99999999);
}

function GetViewportPositionX()
{
	return GetBackgroundInstance().GetViewportPositionX();
}

function GetViewportPositionY()
{
	return GetBackgroundInstance().GetViewportPositionY();
}

function GetViewportSizeX()
{
	return GetBackgroundInstance()
}

function SetViewportPositionX(m_positionX)
{
	GetBackgroundInstance().SetViewportPositionX(m_positionX);
}

function GetViewportWidth()
{
	return GetBackgroundInstance().GetViewportWidth();
}

function PulseScreen(p_magnitude)
{
	GetBackgroundInstance().PulseScreen(p_magnitude);
}