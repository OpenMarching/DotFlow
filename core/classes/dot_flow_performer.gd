class_name DotFlowPerformer
extends Node

var performer_type: int = 0

var performer_label: String = ""

var performer_name: String = "" ## Optional

var performer_sets: Array[PerformerSets] = []

class PerformerSets:
	func _init(_id: String, _location: Vector2, _rotation: float, _height: float):
		id = _id
		location = _location
		rotation = _rotation
		height = _height
	
	var id: String
	var location: Vector2
	var rotation: float
	var height: float
