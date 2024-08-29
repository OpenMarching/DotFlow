extends Control

var time: int = 0

func _ready():
	var mins = floori(time / 60.0 )
	var secs = time % 60
	$Label.text = "%01d:%02d" % [mins, secs]
	$Label.visible = secs % 5 == 0


func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_mask == MOUSE_BUTTON_RIGHT:
			var window = load("res://dotflow/windows/update_show_duration/update_show_duration.tscn").instantiate()
			self.add_child(window)
