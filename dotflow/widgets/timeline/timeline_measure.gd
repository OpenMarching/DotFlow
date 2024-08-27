class_name TimelineMeasure
extends Control

var counts: int
var tempo: int

@onready var counts_box = $HBoxContainer/VBoxContainer/HBoxContainer
@onready var label = $HBoxContainer/VBoxContainer/PanelContainer/Label

func _ready():
	for i in range(counts):
		var count = load("res://dotflow/widgets/timeline/timeline_measure_count.tscn").instantiate()
		count.count = i + 1
		count.tempo = tempo
		counts_box.add_child(count)
	var measure_time = (60.0 / tempo) * counts
	label.text = "%s @ %s bmp, %0.2f s" % [self.counts, self.tempo, measure_time]
