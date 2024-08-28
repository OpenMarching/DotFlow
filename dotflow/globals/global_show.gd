class_name DotFlowShow
extends Node

var show_open: bool = false
var audio_track: AudioStreamMP3 = AudioStreamMP3.new()
var audio_player: AudioStreamPlayer = AudioStreamPlayer.new()
var performers = DotFlowShowPerformers.new()
var timeline = DotFlowShowTimeline.new()

func _ready():
	var instances = [audio_player, performers, timeline]
	for i in instances:
		self.add_child(i, true)
	
	DotFlow.playback.is_playing_changed.connect(_playing_changed)
	
	var file = FileAccess.open("C:/Users/Noah/Desktop/Shadows.mp3", FileAccess.READ)
	audio_track.data = file.get_buffer(file.get_length())
	audio_player.stream = audio_track

func _playing_changed(playing: bool):
	if playing == true:
		if DotFlow.playback.get_track_time() < audio_track.get_length():
			_play_track_at(DotFlow.playback.get_track_time())
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
