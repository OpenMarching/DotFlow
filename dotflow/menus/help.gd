extends Node

func _on_id_pressed(id):
	var item = $".".get_item_text(id)
	
	match item:
		"About":
			add_child(load("res://dotflow/windows/about/about.tscn").instantiate())
		"OpenMarching":
			OS.shell_open("https://openmarching.org")
