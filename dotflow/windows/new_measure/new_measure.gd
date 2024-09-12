extends Window

var measure_idx: int

func _ready():
	$VBoxContainer/Tabs/Counts/layout/counts/counts.value = DotFlow.show.timeline.get_sets()[measure_idx].count
	$VBoxContainer/Tabs/Counts/layout/bpm/bpm.value = DotFlow.show.timeline.get_sets()[measure_idx].tempo
	$VBoxContainer/Tabs/Time/layout/time/time.value = DotFlow.show.timeline.get_sets()[measure_idx].time

func _on_close_requested():
	self.queue_free()

func _on_ok_pressed():
	var counts = $VBoxContainer/Tabs/Counts/layout/counts/counts.value
	var bpm = $VBoxContainer/Tabs/Counts/layout/bpm/bpm.value
	var time = $VBoxContainer/Tabs/Time/layout/time/time.value
	if $VBoxContainer/Tabs.current_tab == 0:
		DotFlow.show.timeline.insert_measure_at(measure_idx + 1, false, {"counts": counts, "tempo": bpm})
	else:
		DotFlow.show.timeline.insert_measure_at(measure_idx + 1, true, {"time": time})
	_on_close_requested()

