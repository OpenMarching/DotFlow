extends PopupMenu


func _on_id_pressed(id):
	var item = $".".get_item_text(id)
	
	match item:
		"Recenter View":
			DotFlow.events.camera_centered.emit()
