// Toggle fullscreen
window_set_fullscreen(!window_get_fullscreen());

// HACK: recreate the surface when fullscreen is toggled
// TODO
var surface = surface_create(1,1);
SetShadowMapSurfaceInstance(surface);