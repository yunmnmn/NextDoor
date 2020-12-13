// Child TextContext

var cainFunction = function()
{
	var childTextContext = new TextContext(noone);
	childTextContext.AddSubText(new SubText("Hallo Bjorn, ", 0.1));
	childTextContext.AddSubText(new SubText("Hallo Sijbren", 0.1));
	
	// Call to render the Child TextRender
	RenderText(childTextContext);
}

// This is the parent TextContext, this will call other TextContexts
var parentTextContext = new TextContext(cainFunction);
parentTextContext.AddSubText(new SubText("slow0123456789", 0.05));
parentTextContext.AddSubText(new SubText("normal0123456789", 0.1));
parentTextContext.AddSubText(new SubText("fast0123456789", 0.2));

// Call the parent text context
RenderText(parentTextContext);