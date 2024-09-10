class_name DotFlowPlayback
extends Node
## Global Playback Manager

signal track_time_changed(time: float)
signal is_playing_changed(playing: bool)

## Player for the audio track assigned in the show.
var audio_player: AudioStreamPlayer = AudioStreamPlayer.new()

var metronome_sound: AudioStreamMP3 = AudioStreamMP3.new()
var metronome_player: AudioStreamPlayer = AudioStreamPlayer.new()
var metronome_sample = "res://audio/AA_Woodblock_03.mp3"

var use_metronome: bool = true

func _ready():
	self.add_child(audio_player)
	self.add_child(metronome_player)
	audio_player.stream = DotFlow.show.audio.audio_track
	DotFlow.playback.is_playing_changed.connect(_playing_changed)
	set_player_volume(DotFlow.config.get_value("playback", "player_volume"))
	
	var file = FileAccess.open(metronome_sample, FileAccess.READ)
	if file == null:
		OS.alert("Cannot Find Metronome Sound.", "Metronome Sound Error")
		return
	metronome_sound.data = file.get_buffer(file.get_length())
	metronome_player.stream = metronome_sound
	metronome_player.volume_db = linear_to_db(0.1)

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
		progress_track(delta)
	
	#if use_metronome == true and is_playing() == true:
		#_play_metronome(delta)


func progress_track(delta):
	if _track_time + delta >= DotFlow.show.timeline.get_show_duration():
		pause()
		set_track_time(DotFlow.show.timeline.get_show_duration())
	_track_time = _track_time + delta

func _play_metronome(_delta):
	var sets: Array[Set] = DotFlow.show.timeline.get_sets()
	var set_times: Array[SetTimes] = DotFlow.show.timeline.get_set_times()
	var active_set: int = get_current_set_index()
	var active_set_start: float = set_times[active_set].start
	var active_set_item: Set = sets[active_set]
	var active_offset = _track_time - active_set_start
	if fmod(active_offset,(60.0 / float(active_set_item.tempo))) < 0.01:
		metronome_player.play(0.0)

func set_playback_to_end():
	var set_times: Array[SetTimes] = DotFlow.show.timeline.get_set_times()
	set_track_time(set_times[set_times.size() - 1].start + set_times[set_times.size() - 1].length)

func set_playback_to_prev_set():
	var current_time: float = get_track_time()
	var set_times: Array[SetTimes] = DotFlow.show.timeline.get_set_times()
	if get_current_set_index() == -1 or get_current_set_index() == 0:
		set_track_time(0.0)
		return
	if set_times[get_current_set_index()].start == current_time:
		set_track_time(set_times[get_current_set_index() - 1].start)
	else:
		set_track_time(set_times[get_current_set_index()].start)


func set_playback_to_next_set():
	var set_times: Array[SetTimes] = DotFlow.show.timeline.get_set_times()
	if get_current_set_index() + 1 < set_times.size():
		set_track_time(set_times[get_current_set_index() + 1].start)


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
	
