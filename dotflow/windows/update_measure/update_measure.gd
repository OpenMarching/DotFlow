extends Window

var measure_idx

func _ready():
	var measure = DotFlow.show.timeline.get_sets()[measure_idx]
	$VBoxContainer/Tabs.current_tab = measure.time_based
	
	$VBoxContainer/Tabs/Counts/layout/counts/counts.value = measure.count
	$VBoxContainer/Tabs/Counts/layout/bpm/bpm.value = measure.tempo
	
	$VBoxContainer/Tabs/Time/layout/time/time.value = measure.time

func _on_close_requested():
	self.queue_free()


func _on_ok_pressed():
	if $VBoxContainer/Tabs.current_tab == 0:
		var counts: int = $VBoxContainer/Tabs/Counts/layout/counts/counts.value
		var tempo: int = $VBoxContainer/Tabs/Counts/layout/bpm/bpm.value
		DotFlow.show.timeline.update_measure_at(measure_idx, false, {"counts": counts, "tempo": tempo})
	else:
		var time: float = $VBoxContainer/Tabs/Time/layout/time/time.value
		DotFlow.show.timeline.update_measure_at(measure_idx, true, {"time": time})
