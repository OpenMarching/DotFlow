class_name DotFlowEnvironment
extends Node

@onready var full_node: Node3D = Node3D.new()
@onready var flat_node: Node3D = Node3D.new()
@onready var paper_node: Node3D = Node3D.new()
@onready var grid_node: Node3D = Node3D.new()

@onready var lua = DFScripter.lua

var active_env_path: String

var active_env: EnvironmentType

func _ready():
	for i in [full_node, flat_node, paper_node, grid_node]:
		self.add_child(i)
		i.visible = false
	grid_node.visible = DFConfiguration.get_value("grid", "enabled")
	active_env_path = "res://default/environments/football_stadium.lua"
	load_environment(active_env_path, 0.625, EnvironmentType.FULL)

var script_config = {
	"type": "environment"
}

enum EnvironmentType {
	FULL,
	FLAT,
	PAPER
}

@onready var environments: Array[Node3D] = [full_node, flat_node, paper_node]

var active_calling_function_node: Node3D = null

func clear_environments():
	for e in environments:
		for i in e.get_children(false):
			i.queue_free()

func load_environment(path: String, grid_size: float, env_type: EnvironmentType = EnvironmentType.FULL):
	lua.do_file(path)
	active_calling_function_node = grid_node
	show_grid(path, grid_size)
	set_environment_type(env_type)

func set_environment_type(env_type: EnvironmentType = EnvironmentType.FULL):
	# if env_type == active_env:
	# 	return
	for i in [full_node, flat_node, paper_node]:
		i.visible = false
	active_env = env_type
	match env_type:
		EnvironmentType.FULL:
			clear_environments()
			active_calling_function_node = full_node
			load_full_environment(active_env_path)
			full_node.visible = true
		EnvironmentType.FLAT:
			clear_environments()
			active_calling_function_node = flat_node
			load_flat_environment(active_env_path)
			flat_node.visible = true
		EnvironmentType.PAPER:
			clear_environments()
			active_calling_function_node = paper_node
			load_paper_environment(active_env_path)
			paper_node.visible = true

func load_full_environment(path: String) -> void:
	var err: LuaError = lua.do_file(path)
	if err is LuaError:
		print("ERROR %d: %s" % [err.type, err.message])
		return
	if lua.function_exists("Full"):
		var err2 = lua.call_function("Full", [])
		if err2:
			print("ERROR %d: %s" % [err2.type, err2.message])
	else:
		OS.alert("No Full Function")
	pass

func load_flat_environment(path: String) -> void:
	var err: LuaError = lua.do_file(path)
	if err is LuaError:
		print("ERROR %d: %s" % [err.type, err.message])
		return
	if lua.function_exists("Flat"):
		lua.call_function("Flat", [])
	else:
		OS.alert("No Flat Function")
	pass

func load_paper_environment(path: String) -> void:
	var err: LuaError = lua.do_file(path)
	if err is LuaError:
		print("ERROR %d: %s" % [err.type, err.message])
		return
	if lua.function_exists("Paper"):
		lua.call_function("Paper", [])
	else:
		OS.alert("No Paper Function")
	pass

func show_grid(path: String, grid_size: float) -> void:
	var err: LuaError = lua.do_file(path)
	if err is LuaError:
		print("ERROR %d: %s" % [err.type, err.message])
		return
	if lua.function_exists("Grid"):
		lua.call_function("Grid", [grid_size])
	else:
		OS.alert("No Grid Function")
	pass


## imports and adds a custom mesh to the scene that cannot be interacted with.
## Can only be called in the "Full" function of the environment script.
func _add_custom_mesh(path: String, location: Vector3, rotation: Vector3, scale: float = 1):
	var gltf_doc_load = GLTFDocument.new()
	var gltf_state_load = GLTFState.new()
	var error = gltf_doc_load.append_from_file(path, gltf_state_load)
	if error == OK:
		var gltf_scene_root_node = gltf_doc_load.generate_scene(gltf_state_load)
		gltf_scene_root_node.scale = Vector3(scale, scale, scale)
		gltf_scene_root_node.position = location
		gltf_scene_root_node.rotation_degrees = rotation
		active_calling_function_node.add_child(gltf_scene_root_node)
	else:
		OS.alert("Couldn't load glTF scene (error: %s %s)." % [error, error_string(error)])

func _add_image(path: String, location: Vector3, rotation: Vector3, scale: float = 1) -> void:
	var ent = Sprite3D.new()
	var image = Image.load_from_file(path)
	if image is Texture2D:
		return OS.alert("Error Importing Image.")
	var err = image.generate_mipmaps()
	if err != OK:
		return OS.alert("Error Generating Image 3D MipMaps.")
	ent.texture = ImageTexture.create_from_image(image)
	ent.position = location
	ent.rotation_degrees = rotation
	ent.scale = Vector3(scale, scale, scale)
	active_calling_function_node.add_child(ent)

## Add a text object to the scene
func _add_text(text, location: Vector3, rotation: Vector3, scale: float = 1, col: String = "WHITE"):
	var ent = CSGMesh3D.new()
	var mesh = TextMesh.new()
	mesh.text = str(text)
	mesh.depth = 0
	ent.mesh = mesh
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color(col)
	ent.material = mat
	ent.scale = Vector3(scale, scale, scale)
	ent.cast_shadow = false
	ent.position = location
	ent.rotation_degrees = rotation
	active_calling_function_node.add_child(ent)

## Draws a Box Shape to the scene
func _draw_plane(x: float, y: float, l: float, w: float, col: String = "WHITE", z: float = 0.01):
	var ent = CSGMesh3D.new()
	var mesh = PlaneMesh.new()
	mesh.size = Vector2(l, w)
	ent.mesh = mesh
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color(col)
	ent.material = mat
	ent.cast_shadow = false
	ent.position = Vector3(x, z, y - w / 2)
	active_calling_function_node.add_child(ent)

## Draws a box shape to the scene, is base of editing area
func _draw_ground_plane(x: float, y: float, l: float, w: float, col: String = "WHITE"):
	var ent = CSGMesh3D.new()
	var mesh = PlaneMesh.new()
	mesh.size = Vector2(l, w)
	ent.mesh = mesh
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color(col)
	ent.material = mat
	ent.position = Vector3(x, 0, y)
	active_calling_function_node.add_child(ent)

## Draws a plane below the ground plane
func _draw_sub_plane(l: float, w: float, col: String = "WHITE"):
	var ent = CSGMesh3D.new()
	var mesh = PlaneMesh.new()
	mesh.size = Vector2(l, w)
	ent.mesh = mesh
	ent.cast_shadow = false
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color(col)
	mat.disable_receive_shadows = true
	ent.material = mat
	ent.position = Vector3(0, -0.1, 0)
	active_calling_function_node.add_child(ent)

func _add_sky_environment(light_rotation: Vector3):
	var world_env = WorldEnvironment.new()
	var env = Environment.new()
	var sky = Sky.new()
	var proc_sky = ProceduralSkyMaterial.new()
	
	env.background_mode = Environment.BG_SKY
	env.sky = sky
	sky.sky_material = proc_sky
	world_env.environment = env
	
	var dir_light = DirectionalLight3D.new()
	dir_light.rotation_degrees = light_rotation
	
	active_calling_function_node.add_child(world_env)
	active_calling_function_node.add_child(dir_light)

func _add_flat_environment(color: String):
	var world_env = WorldEnvironment.new()
	var env = Environment.new()
	
	world_env.environment = env
	
	env.background_mode = Environment.BG_COLOR
	env.background_color = Color(color)
	
	var dir_light = DirectionalLight3D.new()
	dir_light.rotation_degrees = Vector3(0,90,0)
	
	active_calling_function_node.add_child(dir_light)
	active_calling_function_node.add_child(world_env)

func _draw_line(ax, ay, bx, by, thickness: float, col: String = "WHITE", height: float = 0.01) -> void:
	var ent = CSGMesh3D.new()
	var mesh = PlaneMesh.new()
	var length = sqrt(pow((bx - ax), 2) + pow((by - ay), 2))
	mesh.size = Vector2(length, thickness)
	ent.mesh = mesh
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color(col)
	ent.material = mat
	ent.cast_shadow = false
	var avg_pos = (Vector2(ax, ay) + Vector2(bx, by)) / 2
	var radians = atan2(by - avg_pos.y, bx - avg_pos.x)
	ent.rotation_degrees = Vector3(0, rad_to_deg(radians), 0)
	ent.position = Vector3(avg_pos.x, height, avg_pos.y)
	active_calling_function_node.add_child(ent)


func _draw_grid_line(ax, ay, bx, by,thickness = 0.01, scale: float = 1) -> void:
	var ent = CSGMesh3D.new()
	var mesh = PlaneMesh.new()
	var length = sqrt(pow((bx - ax), 2) + pow((by - ay), 2))
	mesh.size = Vector2(length, thickness * scale)
	ent.mesh = mesh
	ent.set_script(load("res://core/classes/dot_flow_environment_grid_line.gd"))
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color(DFConfiguration.get_value("grid", "color"))
	ent.material = mat
	ent.cast_shadow = false
	var avg_pos = (Vector2(ax, ay) + Vector2(bx, by)) / 2
	var radians = atan2(by - avg_pos.y, bx - avg_pos.x)
	ent.rotation_degrees = Vector3(0, rad_to_deg(radians), 0)
	ent.position = Vector3(avg_pos.x, 0.075, avg_pos.y)
	active_calling_function_node.add_child(ent)
