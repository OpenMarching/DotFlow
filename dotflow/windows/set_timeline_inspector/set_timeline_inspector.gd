extends Window


func _ready():
	_refresh_set_inspector()
	DotFlow.events.timeline_refreshed.connect(_refresh_set_inspector)

func _refresh_set_inspector():
	for i in $Scroll/List.get_children():
		i.queue_free()
	
	for i in range(DotFlow.show.timeline.get_sets().size()):
		var window = load("res://dotflow/windows/set_timeline_inspector/set_instance.tscn").instantiate()
		window.measure_idx = i
		$Scroll/List.add_child(window)

func _on_close_requested():
	self.queue_free()
