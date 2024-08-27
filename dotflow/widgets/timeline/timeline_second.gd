extends Control

var time: int = 0

func _ready():
	var mins = floori(time / 60 )
	var secs = time % 60
	$Label.text = "%01d:%02d" % [mins, secs]


func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_mask == MOUSE_BUTTON_LEFT:
			var window = load("res://dotflow/windows/update_show_duration/update_show_duration.tscn").instantiate()
			self.add_child(window)
