class_name DotFlowScripter
extends Node
## Core Scripting host, houses all logic that can be called from lua scripts.[br]No [code]push_variants[/code] should be called outside of this class.

var lua: LuaAPI = LuaAPI.new()

func _ready():
	# Global Functions
	lua.push_variant("print", func(message): print(str(message)))
	lua.push_variant("alert", func(message): OS.alert(str(message), "Alert From Lua Script"))
	lua.push_variant("getPlatform", func(): return OS.get_name())
	# Libaries included.
	lua.bind_libraries(["base","string","table"])
	# Environment Functions
	lua.push_variant("envBuilder", "1.0")
	lua.push_variant("drawGroundPlane", DFEnvironment._draw_ground_plane)
	lua.push_variant("drawSubPlane", DFEnvironment._draw_sub_plane)
	lua.push_variant("drawPlane", DFEnvironment._draw_plane)
	lua.push_variant("drawLine", DFEnvironment._draw_line)
	lua.push_variant("drawGridLine", DFEnvironment._draw_grid_line)
	lua.push_variant("addSkyEnvironment", DFEnvironment._add_sky_environment)
	lua.push_variant("addFlatEnvironment", DFEnvironment._add_flat_environment)
	lua.push_variant("addMesh", DFEnvironment._add_custom_mesh)
	lua.push_variant("addText", DFEnvironment._add_text)
	lua.push_variant("addImage", DFEnvironment._add_image)


