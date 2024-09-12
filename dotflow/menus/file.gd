extends PopupMenu

func _ready():
	self.add_item("New Show")
	self.add_item("Restart Editor")
	self.add_item("Exit Editor")




func _on_id_pressed(id):
	var item = $".".get_item_text(id)
	
	match item:
		"Restart Editor":
			OS.shell_open(OS.get_executable_path())
			get_tree().quit()
		"Exit Editor":
			get_tree().quit()
