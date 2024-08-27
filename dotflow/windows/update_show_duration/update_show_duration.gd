extends Window


func _ready():
	var show_length: int = DotFlow.show.timeline.get_show_duration()
	$VBoxContainer/layout/mins/mins.value = floori(show_length / 60)
	$VBoxContainer/layout/secs/secs.value = show_length % 60

func _on_close_requested():
	self.queue_free()


func _on_ok_pressed():
	var new_dur = (60 * $VBoxContainer/layout/mins/mins.value) + ($VBoxContainer/layout/secs/secs.value)
	DotFlow.show.timeline.set_show_duration(new_dur)
	_on_close_requested()
