extends Node

var load_progress: float = 0.0

var main_window = preload("res://dotflow/main_window.tscn")

func _process(_delta):
	$VBoxContainer/ProgressBar.value = load_progress
	load_progress = load_progress + randf_range(100, 200) * _delta
	if load_progress >= 150:
		get_tree().change_scene_to_packed(main_window)
