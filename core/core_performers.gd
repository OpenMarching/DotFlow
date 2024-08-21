class_name CorePerformers
extends Node

var performers: Array[Performer]

var selected_performers: Array[Performer]


class Performer:
	var type: int = 0
	var label: String = ""
	var name: String = ""
	var sets: Array[DotSet] = []

class DotSet:
	var location: Vector2
	var height: float
