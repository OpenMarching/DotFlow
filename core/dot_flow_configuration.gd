class_name DotFlowConfiguration
extends Node

var cfg_data: Dictionary = {}
var config = ConfigFile.new()

var cfg_path = "user://dot_flow_config.cfg"

func _ready():
	var err = config.load(cfg_path)
	OS.shell_open(OS.get_user_data_dir())
	
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
		window.confirmed.connect(func(): self.queue_free())
		self.add_child(window)
		return
	
	for section in config.get_sections():
		cfg_data[section] = {}
		for key in config.get_section_keys(section):
			cfg_data[section][key] = config.get_value(section, key)
	
	print(cfg_data)

func _added_actions(data):
	if data == "generate":
		_build_default_config()


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
		config.save(cfg_path)
		OS.shell_open(fs.get_absolute_path(cfg_path))
	
