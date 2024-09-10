class_name DotFlowShowAudio
extends Node

var audio_track: AudioStreamMP3 = AudioStreamMP3.new()
@export var audio_path = "E:/SteamLibrary/steamapps/common/Rock of Ages/Original Soundtrack/01 - Main Theme.mp3"


func _ready():
	var file = FileAccess.open(audio_path, FileAccess.READ)
	if file == null:
		OS.alert("No Audio Track Selected For Playback.", "No Audio Track")
		return
	audio_track.data = file.get_buffer(file.get_length())

func get_audio_track_length() -> float:
	return audio_track.get_length()
