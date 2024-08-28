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
	for i in range(counts):
		var count = load("res://dotflow/widgets/timeline/timeline_measure_count.tscn").instantiate()
		count.measure_idx = measure_idx
		count.count = i + 1
		count.total_counts = counts
		count.tempo = tempo
		counts_box.add_child(count)
	var measure_time = (60.0 / tempo) * counts
	measure_start_time = DotFlow.show.timeline.get_set_times()[measure_idx].start
	measure_length = DotFlow.show.timeline.get_set_times()[measure_idx].length
	label.text = "%s @ %s bpm" % [self.counts, self.tempo, measure_start_time, measure_length]
