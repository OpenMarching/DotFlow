extends Node

var load_progress: float = 0.0

var main_window = preload("res://dotflow/main_window.tscn")

func _process(_delta):
	$VBoxContainer/ProgressBar.value = load_progress
	load_progress = load_progress + randf_range(50, 100) * _delta
	if load_progress >= 100:
		get_tree().change_scene_to_packed(main_window)
