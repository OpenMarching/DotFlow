extends Window

var measure_idx

func _ready():
	var measure = DotFlow.show.timeline.get_sets()[measure_idx]
	$VBoxContainer/layout/counts/counts.value = measure.count
	$VBoxContainer/layout/bpm/bpm.value = measure.tempo

func _on_close_requested():
	self.queue_free()


func _on_ok_pressed():
	var counts: int = $VBoxContainer/layout/counts/counts.value
	var tempo: int = $VBoxContainer/layout/bpm/bpm.value
	DotFlow.show.timeline.update_measure_at(measure_idx, counts, tempo)
