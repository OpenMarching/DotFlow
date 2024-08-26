extends PopupMenu

func _on_id_pressed(id):
	var item = $".".get_item_text(id)
	
	match item:
		"Data Folder":
			OS.shell_open(OS.get_user_data_dir())
