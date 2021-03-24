var fadeFinished = function()
{
	ChangeRooms(room_mimiRoom);
}
CreateFader(FadeState.FadeOut, GetDefaultFadingSpeed(), fadeFinished);