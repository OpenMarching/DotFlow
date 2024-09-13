class_name DotFlowShowPerformers
extends Node


var performers: Array[Performer]

var selected_performers: Array[Performer]


func _ready():
	DotFlow.show.timeline.show_set_inserted.connect(_set_inserted)
	DotFlow.show.timeline.show_set_deleted.connect(_set_deleted)
	performers.append(Performer.new())

func _set_inserted(idx):
	for i in performers:
		i._set_inserted(idx)

func _set_deleted(idx):
	for i in performers:
		i._set_deleted(idx)
