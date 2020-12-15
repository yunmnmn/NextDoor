// Child TextContext

var cainFunction = function()
{
	var childTextContext = new TextContext(sprite_mimiAvatarAngry, noone);
	childTextContext.AddSubText(new SubText("HALLO BJORN WAAR BLIJFT MIJN SHADOWMAP, ", 0.5));
	childTextContext.AddSubText(new SubText("HALLO SIJBREN WAAR BLIJVEN MIJN ANIMATIONS", 0.5));
	
	// Call to render the Child TextRender
	RenderText(childTextContext);
}

// This is the parent TextContext, this will call other TextContexts
var parentTextContext = new TextContext(sprite_mimiAvatarNormal, cainFunction);
parentTextContext.AddSubText(new SubText("slow0123456789", 0.05));
parentTextContext.AddSubText(new SubText("normal0123456789", 0.1));
parentTextContext.AddSubText(new SubText("fast0123456789", 0.2));

// Call the parent text context
RenderText(parentTextContext);