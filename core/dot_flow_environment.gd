class_name DotFlowEnvironment
extends Node

@onready var full_node: Node3D = Node3D.new()
@onready var flat_node: Node3D = Node3D.new()
@onready var grid_node: Node3D = Node3D.new()

@onready var lua = DFScripter.lua

var lua_string: String = """
	width = 48.75
	fieldType = "HighSchool"
	
	function Full()
	addSkyEnvironment(Vector3(-45,-30,0))
	drawGroundPlane(0, (width / 2) * -1, 120, width, "DARKGREEN")
	drawSubPlane(1000, 1000, "BLACK")
	
	-- addMesh("G:/Godot_Projects/Open Marching Editor/userBaseFiles/ABeautifulGame/ABeautifulGame.gltf",Vector3(0, 0, width * -1.1), Vector3(0, 90, 0), 10)
	addText("OPEN MARCHING", Vector3(-55, 0.01, width / -2), Vector3(-90, 0, 90), 30, "WHITE")
	addText("OPEN MARCHING", Vector3(55, 0.01, width / -2), Vector3(-90, 0, 270), 30, "WHITE")
	-- addImage("res://sprites/Logo.png", Vector3(0, 0.005, width / -2), Vector3(-90, 0, 0), 2.5)
	
	drawLine(Vector2(5,-5),Vector2(0,-10),0.5,"WHITE")
	
	for i = -50,50 do
		if i % 5 ~= 0 then
			drawPlane(i, 0, 0.1, 0.61, "WHITE") -- High School
			drawPlane(i, (width * -1) + 0.61, 0.1, 0.61, "WHITE")
			if fieldType == "HighSchool" then
				drawPlane(i, (width / -2) - (17.7 / 2), 0.1, 0.61, "WHITE")
				drawPlane(i, (width / -2) + (17.7 / 2) + .61, 0.1, 0.61, "WHITE")
			end
			if fieldType == "College" then -- College
				drawPlane(i, (width / -2) - (13.4 / 2), 0.1, 0.61, "WHITE")
				drawPlane(i, (width / -2) + (13.4 / 2) + .61, 0.1, 0.61, "WHITE")
			end
			if fieldType == "NFL" then -- NFL
				drawPlane(i, (width / -2) - (6 / 2), 0.1, 0.61, "WHITE")
				drawPlane(i, (width / -2) + (6 / 2) + .61, 0.1, 0.61, "WHITE")
			end
		end
		if i % 5 == 0 then
			drawLine(i,0,i,width * -1,0.1,"WHITE")
			drawPlane(i, 0, 0.1, width, "WHITE")
			if i ~= -50 and i ~= 50 then
				if fieldType == "HighSchool" then
					drawPlane(i, (width / -2) - (17.7 / 2), 0.6, 0.1, "WHITE")
					drawPlane(i, (width / -2) + (17.7 / 2) + .1, 0.6, 0.1, "WHITE")
				end
				if fieldType == "College" then -- College
					drawPlane(i, (width / -2) - (13.4 / 2), 0.6, 0.1, "WHITE")
					drawPlane(i, (width / -2) + (13.4 / 2) + .1, 0.6, 0.1, "WHITE")
				end
				if fieldType == "NFL" then -- NFL
					drawPlane(i, (width / -2) - (6 / 2), 0.6, 0.1, "WHITE")
					drawPlane(i, (width / -2) + (6 / 2) + .1, 0.6, 0.1, "WHITE")
				end
			end
		end
		--[[ This is much better but can't use due to bug :(
		if i % 10 == 0 and i ~= -50 and i ~= 50 then
			val = i
			if i < 0 then
				val = i * -1
			end
			addText(tostring(50 - val):gsub(".", "%1 "):sub(1, -2), Vector3(i, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20,"WHITE")
			addText(tostring(50 - val):gsub(".", "%1 "):sub(1, -2), Vector3(i, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
		end
		-- Due to a bug in macOS, we are required to do yard numbers manually, ]]--
		if i % 10 == 0 and i ~= -50 and i ~= 50 then
			addText("1 0", Vector3(40, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20,"WHITE")
			addText("1 0", Vector3(40, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
			addText("2 0", Vector3(30, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20,"WHITE")
			addText("2 0", Vector3(30, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
			addText("3 0", Vector3(20, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20,"WHITE")
			addText("3 0", Vector3(20, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
			addText("4 0", Vector3(10, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20,"WHITE")
			addText("4 0", Vector3(10, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
			addText("5 0", Vector3(0, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20,"WHITE")
			addText("5 0", Vector3(0, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
			addText("4 0", Vector3(-10, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20,"WHITE")
			addText("4 0", Vector3(-10, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
			addText("3 0", Vector3(-20, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20,"WHITE")
			addText("3 0", Vector3(-20, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
			addText("2 0", Vector3(-30, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20,"WHITE")
			addText("2 0", Vector3(-30, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
			addText("1 0", Vector3(-40, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20,"WHITE")
			addText("1 0", Vector3(-40, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
		end
	end

	drawPlane(0, .5, 120, .5, "WHITE")
	drawPlane(0, width * -1, 120, .5, "WHITE")
	drawPlane(-60.5, .5, 1, width + 1, "WHITE")
	drawPlane(60.5, .5, 1, width + 1, "WHITE")
	end
	
	function Grid(gridSize) -- Function that runs creating the grid
	stepper = 0
	
	while stepper >= width * -1 do
		drawLine(-60, stepper, 60, stepper, 0.01, "MAGENTA", 0.0075)
		--drawPlane(0, stepper, 120, 0.01, "PINK", 0.0075)
		stepper = stepper - gridSize
	end
	
	stepper = -60
	
	while stepper <= 60 do
		drawLine(stepper, 0, stepper, width * -1, 0.01, "MAGENTA", 0.0075)
		--drawPlane(stepper, 0, 0.01, width, "PINK", 0.0075)
		stepper = stepper + gridSize
	end
end
	"""

func _ready():
	for i in [full_node, flat_node, grid_node]:
		self.add_child(i)
	load_full_environment()
	load_flat_environment()
	show_grid(true)

func load_full_environment() -> void:
	var err: LuaError = lua.do_string(lua_string)
	if err is LuaError:
		print("ERROR %d: %s" % [err.type, err.message])
		return
	if lua.function_exists("Full"):
		var err2 = lua.call_function("Full", [])
	else:
		OS.alert("No Full Function")
	pass

func load_flat_environment() -> void:
	var err: LuaError = lua.do_string(lua_string)
	if err is LuaError:
		print("ERROR %d: %s" % [err.type, err.message])
		return
	if lua.function_exists("Flat"):
		lua.call_function("Flat", [])
	else:
		OS.alert("No Flat Function")
	pass

func show_grid(show_grid: bool) -> void:
	var err: LuaError = lua.do_string(lua_string)
	if err is LuaError:
		print("ERROR %d: %s" % [err.type, err.message])
		return
	if lua.function_exists("Grid"):
		lua.call_function("Grid", [0.625])
	else:
		OS.alert("No Grid Function")
	pass



## imports and adds a custom mesh to the scene that cannot be interacted with.
func _add_custom_mesh(path: String,location: Vector3,rotation:Vector3, scale: float = 1):
	var gltf_doc_load = GLTFDocument.new()
	var gltf_state_load = GLTFState.new()
	var error = gltf_doc_load.append_from_file(path, gltf_state_load)
	if error == OK:
		var gltf_scene_root_node = gltf_doc_load.generate_scene(gltf_state_load)
		gltf_scene_root_node.scale = Vector3(scale,scale,scale)
		gltf_scene_root_node.position = location
		gltf_scene_root_node.rotation_degrees = rotation
		full_node.add_child(gltf_scene_root_node)
	else:
		OS.alert("Couldn't load glTF scene (error code: %s)." % error_string(error))

func _add_image(path: String,location: Vector3,rotation:Vector3, scale: float = 1) -> void:
	var ent = Sprite3D.new()
	var image = Image.load_from_file(path)
	var err = image.generate_mipmaps()
	if err != OK:
		return OS.alert("Error Generating Image 3D MipMaps.")
	ent.texture = ImageTexture.create_from_image(image)
	ent.position = location
	ent.rotation_degrees = rotation
	ent.scale = Vector3(scale, scale, scale)
	full_node.add_child(ent)

## Add a text object to the scene
func _add_text(text, location: Vector3, rotation:Vector3, scale: float = 1, col: String = "WHITE"):
	var ent = CSGMesh3D.new()
	var mesh = TextMesh.new()
	mesh.text = str(text)
	mesh.depth = 0
	ent.mesh = mesh
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color(col)
	ent.material = mat
	ent.scale = Vector3(scale,scale,scale)
	ent.cast_shadow = false
	ent.position = location
	ent.rotation_degrees = rotation
	full_node.add_child(ent)

## Draws a Box Shape to the scene
func _draw_plane(x: float,y: float,l: float,w: float, col: String = "WHITE",z: float = 0.01):
	var ent = CSGMesh3D.new()
	var mesh = PlaneMesh.new()
	mesh.size = Vector2(l,w)
	ent.mesh = mesh
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color(col)
	ent.material = mat
	ent.cast_shadow = false
	ent.position = Vector3(x, z, y - w / 2)
	full_node.add_child(ent)

## Draws a box shape to the scene, is base of editing area
func _draw_ground_plane(x: float,y: float,l: float,w: float,col: String = "WHITE"):
	var ent = CSGMesh3D.new()
	var mesh = PlaneMesh.new()
	mesh.size = Vector2(l,w)
	ent.mesh = mesh
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color(col)
	ent.material = mat
	ent.position = Vector3(x, 0, y)
	full_node.add_child(ent)

## Draws a plane below the ground plane
func _draw_sub_plane(l: float,w: float,col: String = "WHITE"):
	var ent = CSGMesh3D.new()
	var mesh = PlaneMesh.new()
	mesh.size = Vector2(l,w)
	ent.mesh = mesh
	ent.cast_shadow = false
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color(col)
	mat.disable_receive_shadows = true
	ent.material = mat
	ent.position = Vector3(0, -0.1, 0)
	full_node.add_child(ent)

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
	
	full_node.add_child(world_env)
	full_node.add_child(dir_light)

func _draw_line(ax, ay, bx, by, thickness: float, col: String = "WHITE", height: float = 0.01) -> void:
	var ent = CSGMesh3D.new()
	var mesh = PlaneMesh.new()
	var length = sqrt(pow((bx - ax),2) + pow((by - ay),2))
	mesh.size = Vector2(length,thickness)
	ent.mesh = mesh
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color(col)
	ent.material = mat
	ent.cast_shadow = false
	var avg_pos = (Vector2(ax,ay) + Vector2(bx,by)) / 2
	var radians = atan2(by - avg_pos.y, bx - avg_pos.x)
	ent.rotation_degrees = Vector3(0,rad_to_deg(radians),0)
	ent.position = Vector3(avg_pos.x, height, avg_pos.y)
	flat_node.add_child(ent)
