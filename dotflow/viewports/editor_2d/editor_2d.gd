extends Node

var performer_scene: PackedScene = preload("res://dotflow/classes/performer_2d/performer_2d.tscn")

func _ready():
	DotFlow.show.performers.performers_updated.connect(_redraw_performers)
	_redraw_performers()

func _redraw_performers():
	for i in $PerformersParent.get_children():
		i.queue_free()
	
	for i in range(DotFlow.show.performers.get_performers().size()):
		var performer: Performer2D = performer_scene.instantiate()
		performer.performer_idx = i
		$PerformersParent.add_child(performer)
