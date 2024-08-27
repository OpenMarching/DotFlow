class_name Timeline
extends Control

@onready var timeline = $HBoxContainer/ScrollContainer/HBoxContainer
func _ready():
	_refresh_timeline()

func _refresh_timeline():
	for i in timeline.get_children():
		i.queue_free()
	
	for i in DotFlow.show.timeline.get_sets():
		var timeline_item: TimelineMeasure = load("res://dotflow/widgets/timeline/timeline_measure.tscn").instantiate()
		timeline_item.counts = i.count
		timeline_item.tempo = i.tempo
		timeline.add_child(timeline_item)
