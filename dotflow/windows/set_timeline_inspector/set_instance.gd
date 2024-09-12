extends PanelContainer

var measure_idx: int

func _ready():
	var measure = DotFlow.show.timeline.get_sets()[measure_idx]
	$HBox/Id.text = "Set %.f" % measure_idx
	$HBox/CheckButton.button_pressed = measure.time_based
	if measure.time_based == true:
		$HBox/Info.text = "%fs" % measure.time
	else:
		$HBox/Info.text = "%.fcounts @ %.fbpm" % [measure.count, measure.tempo]


func _on_button_pressed():
	var confirm = ConfirmationDialog.new()
	confirm.dialog_text = "Are You Sure you want to delete set %.f?" % measure_idx
	confirm.visible = true
	confirm.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
	confirm.confirmed.connect(func(): DotFlow.show.timeline.delete_measure_at(measure_idx))
	self.add_child(confirm)
