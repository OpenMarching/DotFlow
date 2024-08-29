class_name DotFlowPlayback
extends Node
## Global Playback manager for DotFlow

signal track_time_changed(time: float)
signal is_playing_changed(playing: bool)

## Player for the audio track assigned in the show.
var audio_player: AudioStreamPlayer = AudioStreamPlayer.new()

func _ready():
	self.add_child(audio_player)
	audio_player.stream = DotFlow.show.audio.audio_track
	DotFlow.playback.is_playing_changed.connect(_playing_changed)
	set_player_volume(DotFlow.config.get_value("playback", "player_volume"))

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

## prefer to use [code]set_track_time()[/code]
## This function is used to force update the track time and continue playback.
func _set_track_time_force(time: float) -> void:
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

func _playing_changed(playing: bool):
	if playing == true:
		if get_track_time() < DotFlow.show.audio.audio_track.get_length():
			_play_track_at(get_track_time())
		else:
			printerr("Track Position Exceeds Audio Length.")
	else:
		_stop_track()

func _play_track_at(time: float):
	audio_player.play(time)

func _stop_track():
	audio_player.stop()

func set_player_volume(volume: float):
	audio_player.volume_db = linear_to_db(volume)

func get_player_volume() -> float:
	return db_to_linear(audio_player.volume_db)
	
