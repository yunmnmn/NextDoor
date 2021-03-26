function hide()
{
	instance_creditsCards.visible = false;
}
fader = CreateFader(FadeState.FadeOut, GetDefaultFadingSpeed(), hide);