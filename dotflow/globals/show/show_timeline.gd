class_name DotFlowShowTimeline
extends Node

signal show_duration_changed(length: int)

var _sets: Array[Set] = [
	Set.new(8, 120),
	Set.new(12, 120),
	Set.new(4, 60),
]

func delete_measure_at(index: int):
	_sets.remove_at(index)

func update_measure_at(index: int, counts: int, bpm: int):
	print(_sets[index])
	_sets[index] = Set.new(counts, bpm)
	print(_sets[index])
	DotFlow.events.timeline_refreshed.emit()

## Inserts a new measure at the given index, pushing the measure at that current index to the subsequent index
func insert_measure_at(index: int, counts: int, bpm: int):
	_sets.insert(index, Set.new(counts, bpm))
	DotFlow.events.timeline_refreshed.emit()

var _show_duration: float = 600

func get_show_duration() -> float:
	return _show_duration

## Sets the Show Length Duration in Seconds
func set_show_duration(duration: int):
	_show_duration = duration
	show_duration_changed.emit(duration)

func get_sets() -> Array[Set]:
	return _sets

func get_set_times() -> Array[SetTimes]:
	var arr: Array[SetTimes] = []
	var start_time: float = 0
	for i in _sets:
		var _set = SetTimes.new()
		_set.start = start_time
		_set.length = (60. / i.tempo) * i.count
		start_time = start_time + (60. / i.tempo) * i.count
		arr.append(_set)
	return arr

