class_name TimelineMeasure
extends Control

var measure_idx: int
var measure_start_time: float
var measure_length: float
var counts: int
var tempo: int

@onready var counts_box = $HBoxContainer/VBoxContainer/HBoxContainer
@onready var label = $HBoxContainer/VBoxContainer/PanelContainer/Label

func _ready():
	measure_start_time = DotFlow.show.timeline.get_set_times()[measure_idx].start
	measure_length = DotFlow.show.timeline.get_set_times()[measure_idx].length
	for i in range(counts):
		var count = load("res://dotflow/widgets/timeline/timeline_measure_count.tscn").instantiate()
		count.measure_idx = measure_idx
		count.count = i + 1
		count.total_counts = counts
		count.tempo = tempo
		counts_box.add_child(count)
	var measure_time = (60.0 / tempo) * counts
	self.custom_minimum_size.x = measure_time * DotFlow.config.get_value("timeline","pixel_per_second")
	label.text = "Page %s" % [self.measure_idx]


func _on_insert_measure_after_pressed():
	var window = load("res://dotflow/windows/new_measure/new_measure.tscn").instantiate()
	window.measure_idx = measure_idx
	self.add_child(window)


func _on_panel_container_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_mask == MOUSE_BUTTON_LEFT:
				var start_time = DotFlow.show.timeline.get_set_times()[measure_idx].start
				DotFlow.playback.set_track_time(start_time)
		if event.button_mask == MOUSE_BUTTON_RIGHT:
			var window = load("res://dotflow/windows/update_measure/update_measure.tscn").instantiate()
			window.measure_idx = measure_idx
			self.add_child(window)
