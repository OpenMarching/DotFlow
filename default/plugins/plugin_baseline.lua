-- Input allows the plugin to accept input from a window that appears in the UI.

-- type : allowed types {"string", "int", "float", "vector2"}
-- display : text to display in the plugin popup window, or false to hide

input = {
	text={type="string",display="Text To Display"}
	location={type="vector2",display=false}
}

-- Function that runs after any inputs are collected, and confirmed.
function Plugin(input) then
	DF -- Global object to interact with the DotFlow API.
end
