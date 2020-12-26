if(keyboard_check_pressed(vk_space))
{
	// Child TextContext
	var cainFunction = function()
	{	
		// Chain 2
		var chainFunction2 = function()
		{
			SetControlState(PlayerControlState.PlayerControl);
		}
		
		var childTextContext = new TextContext(sprite_youngsterAvatarNormal, chainFunction2);
		childTextContext.AddSubText(new SubText("Oh I'm very sorry. I'll turn down the music.", 0.2));
	
		// Call to render the Child TextRender
		RenderText(childTextContext);
	}

	// This is the parent TextContext, this will call other TextContexts
	var parentTextContext = new TextContext(sprite_mimiAvatarAngry, cainFunction);
	parentTextContext.AddSubText(new SubText("Hello neighbor, why are you so loud!?", 0.2));

	// Call the parent text context
	if(RenderText(parentTextContext))
	{
		// If it's successfully displaying the text, Disable the player control
		SetControlState(PlayerControlState.PlayerNoControl);
	}
}