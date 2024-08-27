class_name DotFlowShowTimeline
extends Node

var sets: Array[Set] = [
	Set.new(8, 120),
	Set.new(8, 120),
	Set.new(8, 120)
]

func get_sets() -> Array[Set]:
	return sets

class Set:
	func _init(count: int, tempo: int):
		self.count = count
		self.tempo = tempo
	
	var count: int
	var tempo: int
	
	var _start_time: float
	var _set_length: float
