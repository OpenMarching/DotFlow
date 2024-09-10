extends Node

var progress: Array[float] = []

var loading_status: int

var main_window_path = "res://dotflow/main_window.tscn"

func _ready():
	ResourceLoader.load_threaded_request(main_window_path)

func _process(_delta):
	loading_status = ResourceLoader.load_threaded_get_status(main_window_path, progress)
	
	print(progress[0])
	
	match loading_status:
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS:
			$VBoxContainer/ProgressBar.value = progress[0] * 200
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
			get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(main_window_path))
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_FAILED:
			printerr("Error. Could not load Main Window")
