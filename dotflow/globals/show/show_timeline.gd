class_name DotFlowShowTimeline
extends Node

signal show_duration_changed(length: int)

var _sets: Array[Set] = [
	Set.new(8, 60),
	Set.new(8, 120),
	Set.new(8, 120)
]

var _show_duration: float = 600

func get_show_duration() -> int:
	return _show_duration

## Sets the Show Length Duration in Seconds
func set_show_duration(duration: int):
	_show_duration = duration
	show_duration_changed.emit(duration)

func get_sets() -> Array[Set]:
	return _sets

class Set:
	func _init(count: int, tempo: int):
		self.count = count
		self.tempo = tempo
	
	var count: int
	var tempo: int
	
	var _start_time: float
	var _set_length: float
