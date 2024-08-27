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
