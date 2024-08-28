class_name DotFlowShowTimeline
extends Node

signal show_duration_changed(length: int)

var _sets: Array[Set] = [
	Set.new(8, 60),
	Set.new(8, 120),
	Set.new(8, 120),
	Set.new(16, 240),
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

func get_set_times() -> Array[SetTimes]:
	var arr: Array[SetTimes]
	var start_time: float = 0
	for i in _sets:
		var _set = SetTimes.new()
		_set.start = start_time
		_set.length = (60. / i.tempo) * i.count
		start_time = start_time + (60. / i.tempo) * i.count
		arr.append(_set)
	return arr

