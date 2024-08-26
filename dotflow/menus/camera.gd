extends Node


func _on_id_pressed(id):
	var item = $".".get_item_text(id)
	
	match item:
		"Recenter View":
			pass
