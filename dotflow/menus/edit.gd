extends PopupMenu

var submenu_data_folders = PopupMenu.new()

func _ready():
	submenu_data_folders.set_name("data_folders")
	submenu_data_folders.add_item("Data Folder")
	submenu_data_folders.add_item("Scripts")
	self.add_child(submenu_data_folders)
	self.add_submenu_item("Data Folders", "data_folders")
	submenu_data_folders.id_pressed.connect(_submenu_data_folders_pressed)

func _submenu_data_folders_pressed(id):
	var item = submenu_data_folders.get_item_text(id)
	
	match item:
		"Data Folder":
			OS.shell_open(OS.get_user_data_dir())
		"Scripts":
			OS.shell_open(OS.get_user_data_dir() + "/scripts")


func _on_id_pressed(id):
	var item = $".".get_item_text(id)
	
	match item:
		"Data Folder":
			OS.shell_open(OS.get_user_data_dir())
