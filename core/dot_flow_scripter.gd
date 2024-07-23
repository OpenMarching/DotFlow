class_name DotFlowScripter
extends Node
## Core Scripting host, houses all logic that can be called from lua scripts.

var lua: LuaAPI = LuaAPI.new()

func _lua_print(message: String) -> void:
	print(message)

func _lua_alert(message) -> void:
	OS.alert(str(message), "Alert From Lua Script")

func _ready():
	# Global Functions
	lua.push_variant("print", _lua_print)
	lua.push_variant("alert", _lua_alert)
	# Libaries included.
	lua.bind_libraries(["base","string","table"])
	# Environment Functions
	lua.push_variant("envBuilder", "1.0")
	lua.push_variant("drawGroundPlane", DFEnvironment._draw_ground_plane)
	lua.push_variant("drawSubPlane", DFEnvironment._draw_sub_plane)
	lua.push_variant("drawPlane", DFEnvironment._draw_plane)
	lua.push_variant("drawLine", DFEnvironment._draw_line)
	lua.push_variant("addSkyEnvironment", DFEnvironment._add_sky_environment)
	lua.push_variant("addMesh", DFEnvironment._add_custom_mesh)
	lua.push_variant("addText", DFEnvironment._add_text)
	lua.push_variant("addImage", DFEnvironment._add_image)


