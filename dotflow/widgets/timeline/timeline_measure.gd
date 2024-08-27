class_name TimelineMeasure
extends Control

var counts: int
var tempo: int

@onready var counts_box = $HBoxContainer/VBoxContainer/HBoxContainer
@onready var label = $HBoxContainer/VBoxContainer/Label

func _ready():
	for i in range(counts):
		var count = load("res://dotflow/widgets/timeline/timeline_measure_count.tscn").instantiate()
		count.count = i + 1
		counts_box.add_child(count)
	label.text = "%s @ %s bmp" % [self.counts, self.tempo]
