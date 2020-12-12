function RegisterTextboxInstance(p_instance)
{
	// Check if the background instance is 0 first
	assert_fail(global.textboxInstance != noone, "textboxInstance variable should be initialized by the object_global to 0 first. Make sure that object_global is initialized first in the room order");
	// Check if the parameter instance is valid
	assert_fail(p_instance == 0, "Passed textbox isn't valid");
	
	global.textboxInstance = p_instance;
}

// Renders the text in the textbox
function RenderText(p_textContext)
{
	// Check if the background instance is 0 first
	assert_fail(global.textboxInstance == noone, "No textbox instance is registered");
	
	global.textboxInstance.RenderText(p_textContext);
}

// Renders text over time
function RenderTextOvertimeInTextBox(p_text)
{
	
}