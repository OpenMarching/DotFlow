extends PanelContainer


func _ready():
	var track_length: float = DotFlow.show.audio.get_audio_track_length()
	var track_render_length: float = track_length * DotFlow.config.get_value("timeline","pixel_per_second")
	self.custom_minimum_size = Vector2(track_render_length, 4)

