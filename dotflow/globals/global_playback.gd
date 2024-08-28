class_name DotFlowPlayback
extends Node

signal track_time_changed(time: float)
signal is_playing_changed(playing: bool)

var _track_time: float = 0.0:
	set(value):
		track_time_changed.emit(value)
		_track_time = value

var _is_playing: bool = false:
	set(value):
		is_playing_changed.emit(value)
		_is_playing = value

func is_playing() -> bool:
	return _is_playing

func get_track_time() -> float:
	return _track_time

func set_track_time(time: float) -> void:
	if is_playing():
		pause()
	_track_time = time

func play() -> void:
	_is_playing = true

func pause() -> void:
	_is_playing = false

func _process(delta):
	if _is_playing == true:
		if _track_time + delta >= DotFlow.show.timeline.get_show_duration():
			pause()
			set_track_time(DotFlow.show.timeline.get_show_duration())
		_track_time = _track_time + delta

func set_playback_to_end():
	var set_times: Array[SetTimes] = DotFlow.show.timeline.get_set_times()
	set_track_time(set_times[set_times.size() - 1].start + set_times[set_times.size() - 1].length)

func set_playback_to_prev_set():
	var current_time: float = get_track_time()
	var set_times: Array[SetTimes] = DotFlow.show.timeline.get_set_times()
	if set_times[get_current_set_index()].start == current_time:
		set_track_time(set_times[get_current_set_index() - 1].start)
	else:
		set_track_time(set_times[get_current_set_index()].start)


func set_playback_to_next_set():
	var current_time: float = get_track_time()
	var set_times: Array[SetTimes] = DotFlow.show.timeline.get_set_times()
	if get_current_set_index() + 1 < set_times.size():
		set_track_time(set_times[get_current_set_index() + 1].start)
	else:
		set_track_time(float(set_times[set_times.size() - 1].start) + float(set_times[set_times.size() - 1].length))


func get_current_set_index() -> int:
	var current_time: float = get_track_time()
	var set_times: Array[SetTimes] = DotFlow.show.timeline.get_set_times()
	for i in range(set_times.size()):
		if current_time >= set_times[i].start and current_time < set_times[i].start + set_times[i].length:
			return i
	return -1
