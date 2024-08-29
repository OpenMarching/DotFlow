class_name DotFlowShowAudio
extends Node

var audio_track: AudioStreamMP3 = AudioStreamMP3.new()
var audio_path = "E:/SteamLibrary/steamapps/music/Frostpunk Original Soundtrack/Frostpunk Original Soundtrack-Normal/Piotr Musiał - Frostpunk (Original Soundtrack) - 09 - The City Must Survive.mp3"


func _ready():
	var file = FileAccess.open(audio_path, FileAccess.READ)
	audio_track.data = file.get_buffer(file.get_length())


func get_audio_track_length() -> float:
	return audio_track.get_length()
