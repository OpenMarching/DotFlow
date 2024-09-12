extends PopupMenu

func _ready():
	self.add_item("Set Timeline Inspector")
	self.add_item("Modify Show Options")

func _on_id_pressed(id):
	var item = $".".get_item_text(id)
	
	match item:
		"Modify Show Options":
			var window = load("res://dotflow/windows/show_options/show_options.tscn").instantiate()
			self.add_child(window)
		"Set Timeline Inspector":
			var window = load("res://dotflow/windows/set_timeline_inspector/set_timeline_inspector.tscn").instantiate()
			self.add_child(window)
