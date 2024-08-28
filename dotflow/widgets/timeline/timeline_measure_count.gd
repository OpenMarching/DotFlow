extends Control

var measure_idx: int
var total_counts: int
var count: int = 0
var time: float = 0.0
var tempo: int = 0

func _ready():
	#self.size = Vector2((60 / tempo) * 50, 0)
	self.custom_minimum_size = Vector2((60.0 / tempo) * 50.0, 0)


func _on_button_pressed():
	pass
	#var set_times: Array[SetTimes] = DotFlow.show.timeline.get_set_times()
	#var time_per_count: float = set_times[measure_idx].length / total_counts
	#var new_time: float = set_times[measure_idx].start + (time_per_count * count)
	#DotFlow.playback.set_track_time(new_time)
