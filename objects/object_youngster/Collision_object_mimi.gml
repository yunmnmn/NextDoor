if(keyboard_check_pressed(vk_space))
{
	// TODO: this is ugly as fuck, fix this, lol
	
	// Child TextContext
	var cainFunction = function()
	{	
		// Chain 2
		var chainFunction2 = function()
		{
			var chainChainChainFunction = function()
			{
				SetControlState(PlayerControlState.PlayerControl);
				
				var animationReverseEnd = function()
				{
					PlayAnimation(sprite_youngsterIdle, noone);
				}
				
				// Reverse animation
				PlayAnimation(anim_youngsterPoint, animationReverseEnd);
				image_speed = -1;
				image_index = image_number - 1;
			}
			
			// This is the parent TextContext, this will call other TextContexts
			var childChildText = new TextContext(sprite_mimiAvatarAngry, chainChainChainFunction);
			childChildText.AddSubText(new SubText("Lower the volume of your music!", 0.5));
			RenderText(childChildText)
		}
		
		var childTextContext = new TextContext(sprite_youngsterAvatarNormal, chainFunction2);
		childTextContext.AddSubText(new SubText("Listen here! I don't care!", 0.2));
	
		// Call to render the Child TextRender
		if(RenderText(childTextContext))
		{
			var endAnimation = function()
			{
				image_speed = 0;
				image_index = image_number - 1;
			}
			
			PlayAnimation(anim_youngsterPoint, endAnimation);
		}
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