extends Control


func _ready():
	for i in [$HBoxContainer/Track,$HBoxContainer/Audio,$HBoxContainer/Slip]:
		i.visible = DotFlow.config.get_value("debug","track_time_slippage")
	
	
	DotFlow.playback.is_playing_changed.connect(_is_playing_changed)
	DotFlow.playback.track_time_changed.connect(_track_time_changed)
	$HBoxContainer/Track.text = "0.0000"
	$HBoxContainer/AudioVolume.value = DotFlow.playback.get_player_volume()

func _is_playing_changed(is_playing: bool):
	if is_playing == false and $HBoxContainer/Play.button_pressed == true:
		$HBoxContainer/Play.button_pressed = false

func _track_time_changed(time: float):
	$HBoxContainer/Track.text = str("%.04f" % time)
	$HBoxContainer/Audio.text = str(DotFlow.playback.audio_player.get_playback_position())
	$HBoxContainer/Slip.text = str(float($HBoxContainer/Track.text) - float($HBoxContainer/Audio.text))
	_track_time_audio_slippage_and_correct(time)

func _track_time_audio_slippage_and_correct(time: float):
	var track_time: float = time
	var audio_time: float = DotFlow.playback.audio_player.get_playback_position()
	
	if audio_time == 0:
		return
	
	var slip: float = track_time - audio_time 
	if slip < -0.1 or slip > 0.1:
		DotFlow.playback._set_track_time_force(audio_time)

func _on_play_toggled(toggled_on):
	if toggled_on:
		DotFlow.playback.play()
	else:
		DotFlow.playback.pause()


func _on_beginning_pressed():
	if DotFlow.playback.is_playing() == true:
		DotFlow.playback.pause()
	DotFlow.playback.set_track_time(0.0)


func _on_next_pressed():
	DotFlow.playback.set_playback_to_next_set()


func _on_previous_pressed():
	DotFlow.playback.set_playback_to_prev_set()


func _on_end_pressed():
	DotFlow.playback.set_playback_to_end()


func _on_h_slider_value_changed(value):
	DotFlow.config.update_value("playback","player_volume", value)
	DotFlow.playback.set_player_volume(value)
	_update_volume_image(value)


func _update_volume_image(value: float):
	var texture: TextureRect = $HBoxContainer/TextureRect
	var image: String
	if value < 0.1:
		image = "res://addons/lucide/icons/volume.svg"
	elif value < 0.5:
		image = "res://addons/lucide/icons/volume-1.svg"
	else:
		image = "res://addons/lucide/icons/volume-2.svg"
	texture.texture = load(image)
