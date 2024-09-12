extends Window

var measure_idx: int

func _on_close_requested():
	self.queue_free()

func _on_ok_pressed():
	var counts = $VBoxContainer/layout/counts/counts.value
	var bpm = $VBoxContainer/layout/bpm/bpm.value
	DotFlow.show.timeline.insert_measure_at(measure_idx + 1, false, {"counts": counts, "tempo": bpm})
	_on_close_requested()
