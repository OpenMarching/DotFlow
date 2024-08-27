class_name DotFlowShowPerformers
extends Node


var performers: Array[Performer]

var selected_performers: Array[Performer]


class Performer:
	var type: int
	var label: String
	var name: String
	var sets: Array[DotSets]

class DotSets:
	var location: Vector2
	var height: float
	var rotation: float
