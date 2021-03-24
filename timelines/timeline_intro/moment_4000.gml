var fadeFinished = function()
{
	instance_splash.visible = false;
	instance_disclaimer.visible = true;
	CreateFader(FadeState.FadeIn, GetDefaultFadingSpeed(), noone);
}
CreateFader(FadeState.FadeOut, GetDefaultFadingSpeed(), fadeFinished);