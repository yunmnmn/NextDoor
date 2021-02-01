// --------- Entry Point -------------
switch(GetGlobalGameState())
{
	case GlobalGameStates.MimiGointToYoungsterAgain:
		MimiConversationYoungster();
		break;
	default:
		break;
}