class_name DotFlowConfiguration
extends Node

var cfg_data: Dictionary = {}:
	set(value):
		print(value)

var config = ConfigFile.new()

var cfg_path = "user://dot_flow_config.cfg"

var using_default: bool = false

func _ready():
	_load_config_from_user_data()

func _load_config_from_user_data():
	cfg_data = {}
	var err = config.load(cfg_path)
	
	if err != OK:
		var window: ConfirmationDialog = ConfirmationDialog.new()
		window.visible = true
		window.dialog_text = "Could not load DotFlow Config File"
		window.title = "Error Loading Config"
		window.add_button("Generate Config", false, "generate")
		window.cancel_button_text = "Exit"
		window.ok_button_text = "Use Default"
		window.exclusive = true
		window.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
		window.custom_action.connect(_added_actions)
		window.canceled.connect(func(): get_tree().quit(0))
		window.confirmed.connect(_load_default)
		self.add_child(window)
		return
	
	for section in config.get_sections():
		cfg_data[section] = {}
		for key in config.get_section_keys(section):
			cfg_data[section][key] = config.get_value(section, key)
	print(cfg_data)

func _load_default():
	using_default = true
	var default = ConfigFile.new()
	var err = default.load("res://default/configuration/dot_flow_defaults.cfg")
		
	if err != OK:
		OS.alert("Failed To Load Default Config, Your Install May Be Corrupted.", "Failed Loading Defaults")
		return
	
	for section in default.get_sections():
		cfg_data[section] = {}
		for key in  default.get_section_keys(section):
			cfg_data[section][key] = default.get_value(section, key)
	queue_free()

func _added_actions(data):
	if data == "generate":
		_build_default_config()

func update_value(section, key, value):
	if using_default:
		OS.alert("Cannot update config when using defaults. Restart the editor and create a config.", "Cannot Update Config")
		return 
	cfg_data[section][key] = value
	config.set_value(section, key, value)
	config.save(cfg_path)

func get_value(section, key) -> Variant:
	var error = cfg_data.get(section).get(key)
	
	match typeof(error):
		TYPE_NIL:
			var default = ConfigFile.new()
			var err = default.load("res://default/configuration/dot_flow_defaults.cfg")
		
			if err != OK:
				OS.alert("Failed To Load Default Config Value During Runtime Access Call, The Application Needs to Quit.", "Failed Loading Default")
				get_tree().quit(1)
				return
			
			var alert_message = "( %s , %s ) Attempted to get value not valid in your configuration. Using Default. You may need to rebuild your Config." % [section, key]
			OS.alert(alert_message, "Attempted to access invalid value.")
			print(error)
			return default.get_value(section, key)
	
	return error

func _build_default_config():
	var fs = DirAccess.open("user://")
	if fs.file_exists(cfg_path):
		fs.remove(cfg_path)
	else: 
		var default = ConfigFile.new()
		var err = default.load("res://default/configuration/dot_flow_defaults.cfg")
		
		if err != OK:
			OS.alert("Failed To Load Default Config, Your Install May Be Corrupted.", "Failed Loading Defaults")
			return
		
		for section in default.get_sections():
			for key in default.get_section_keys(section):
				config.set_value(section, key, default.get_value(section, key))
		var err2 = config.save(cfg_path)
		
		if err2 != OK:
			print(err2)
	queue_free()

func _dump_and_rebuild_config():
	var fs = DirAccess.open("user://")
	if fs.file_exists(cfg_path):
		fs.remove(cfg_path)
	_build_default_config()

func _audit_and_update_config():
	var default = ConfigFile.new()
	var err = default.load("res://default/configuration/dot_flow_defaults.cfg")
	
	if err != OK:
		OS.alert("Failed To Load Default Config, Your Install May Be Corrupted.", "Failed Loading Defaults")
		return
	
	for section in default.get_sections():
		for key in default.get_section_keys(section):
			var error = config.get_value(section, key)
			match typeof(error):
				TYPE_NIL:
					config.set_value(section, key, default.get_value(section, key))
	config.save(cfg_path)
	_load_config_from_user_data()
