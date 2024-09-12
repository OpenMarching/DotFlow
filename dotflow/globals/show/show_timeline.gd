class_name DotFlowShowTimeline
extends Node

signal show_duration_changed(length: int)

var delay_start: float = 0

var _sets: Array[Set] = [
	Set.new(true, {"time": 10.0}),
	Set.new(false, {"counts": 8, "tempo": 120}),
	Set.new(false, {"counts": 12, "tempo": 120}),
	Set.new(false, {"counts": 4, "tempo": 60}),
]

func delete_measure_at(index: int):
	_sets.remove_at(index)

func update_measure_at(index: int, use_time: bool, options: Dictionary):
	print(_sets[index])
	if use_time == true:
		_sets[index] = Set.new(true, {"time": options["time"]})
	else:
		_sets[index] = Set.new(false, {"counts": options["counts"], "tempo": options["tempo"]})
	print(_sets[index])
	DotFlow.events.timeline_refreshed.emit()

## Inserts a new measure at the given index, pushing the measure at that current index to the subsequent index
func insert_measure_at(index: int, use_time: bool, options: Dictionary):
	if use_time == true:
		_sets.insert(index, Set.new(true, {"time": options["time"]}))
	else:
		_sets.insert(index, Set.new(false, {"counts": options["counts"], "tempo": options["tempo"]}))
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
	var start_time: float = 0 + delay_start
	if delay_start > 0.0:
		var _set = SetTimes.new()
		_set.start = 0.0
		_set.length = delay_start
	for i in _sets:
		var _set = SetTimes.new()
		_set.start = start_time
		if i.time_based:
			_set.length = i.time
			start_time = start_time + i.time
		else:
			_set.length = (60. / i.tempo) * i.count
			start_time = start_time + (60. / i.tempo) * i.count
		
		arr.append(_set)
	return arr

func get_start_delay() -> float:
	return delay_start

func set_start_delay(delay: float):
	delay_start = delay
	DotFlow.events.timeline_refreshed.emit()
