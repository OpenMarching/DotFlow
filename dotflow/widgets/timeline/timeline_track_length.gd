extends PanelContainer


func _ready():
	var track_length: float = DotFlow.show.audio.get_audio_track_length()
	var track_render_length: float = track_length * 50.0
	self.custom_minimum_size = Vector2(track_render_length, 4)

