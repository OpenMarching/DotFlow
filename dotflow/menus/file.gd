extends PopupMenu

func _ready():
	self.add_item("New Show")
	self.add_item("Exit Editor")




func _on_id_pressed(id):
	var item = $".".get_item_text(id)
	
	match item:
		"Exit Editor":
			get_tree().quit()
