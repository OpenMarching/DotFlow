extends Window


func _ready():
	$VBoxContainer/TabContainer/Audio/Options/Path/Path.text = DotFlow.show.audio.get_audio_file_path()

func _on_close_requested():
	self.queue_free()


func _on_update_pressed():
	DotFlow.show.audio.set_audio_file_path($VBoxContainer/TabContainer/Audio/Options/Path/Path.text)
	_on_close_requested()
