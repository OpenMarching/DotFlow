extends Control

var measure_idx: int
var total_counts: int
var count: int = 0
var time: float = 0.0
var tempo: int = 0


func _set_track_to_location():
	var measure_start_time = DotFlow.show.timeline.get_set_times()[measure_idx].start
	var measure_length = DotFlow.show.timeline.get_set_times()[measure_idx].length
	var c_time: float = measure_start_time + ((measure_length / total_counts) * (count - 1)) 
	DotFlow.playback.set_track_time(c_time)


func _on_button_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_mask == MOUSE_BUTTON_LEFT:
			_set_track_to_location()
		if event.button_mask == MOUSE_BUTTON_RIGHT:
			var window = ConfirmationDialog.new()
			window.dialog_text = "Split This Measure on count %s?" % count
			window.confirmed.connect(_split_measure)
			window.visible = true
			window.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
			self.add_child(window)


func _split_measure():
	DotFlow.show.timeline.update_measure_at(measure_idx, count - 1, tempo)
	DotFlow.show.timeline.insert_measure_at(measure_idx + 1, total_counts - count + 1, tempo)
