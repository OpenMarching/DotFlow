class_name DotFlowShowAudio
extends Node

var audio_track: AudioStreamMP3 = AudioStreamMP3.new()
@export var _audio_path = "D:/SteamLibrary/steamapps/common/KentuckyRouteZero/Soundtrack/Act_One_Soundtrack/Ben Babbitt - Kentucky Route Zero Act I - 03 You've Got To Walk- The Bedquilt Ramblers.mp3"


func _ready():
	_load_audio_file()

func get_audio_track_length() -> float:
	return audio_track.get_length()

func get_audio_file_path() -> String:
	return _audio_path

func set_audio_file_path(path: String) -> void:
	_audio_path = path
	_load_audio_file()
	Toast.message("Audio File Path Modified")
	DotFlow.events.timeline_refreshed.emit()


func _load_audio_file():
	var file = FileAccess.open(_audio_path, FileAccess.READ)
	if file == null:
		OS.alert("No Audio Track Selected For Playback.", "No Audio Track")
		return
	audio_track.data = file.get_buffer(file.get_length())
