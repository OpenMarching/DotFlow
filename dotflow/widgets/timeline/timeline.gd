class_name Timeline
extends Control

@onready var timeline = $HBoxContainer/ScrollContainer/VBoxContainer/TimelineMeasures
@onready var timetrack = $HBoxContainer/ScrollContainer/VBoxContainer/TimeSequence
@onready var timecursor = $HBoxContainer/ScrollContainer/VBoxContainer/Control/Cursor

var time = 0.0

func _process(delta):
	_handle_drag(delta)
	#_follow_timeline_cursor()


func _follow_timeline_cursor():
	if DotFlow.playback.is_playing() and $HBoxContainer/ScrollContainer/VBoxContainer/Control/Cursor.position.x > 300:
		var offset: float = DotFlow.playback.get_track_time()
		$HBoxContainer/ScrollContainer.scroll_horizontal = offset * 50 - $HBoxContainer/ScrollContainer.size.x / 2


func _set_local_time(_time: float):
	timecursor.position.x = _time * 50

func _ready():
	DotFlow.playback.track_time_changed.connect(_set_local_time)
	_refresh_timeline()
	DotFlow.show.timeline.show_duration_changed.connect(_show_duration_changed)
	DotFlow.events.timeline_refreshed.connect(_refresh_timeline)

func _show_duration_changed(_duration: float):
	_refresh_timeline()

func _refresh_timeline():
	for i in timeline.get_children():
		i.queue_free()
	for i in timetrack.get_children():
		i.queue_free()
	
	for i in range(DotFlow.show.timeline.get_show_duration()):
		var timesec = load("res://dotflow/widgets/timeline/timeline_second.tscn").instantiate()
		timesec.time = int(i)
		timetrack.add_child(timesec)
	
	var timeline_sets: Array[Set] = DotFlow.show.timeline.get_sets()
	
	var audio_track = $HBoxContainer/ScrollContainer/VBoxContainer/AudioTrack
	for i in audio_track.get_children():
		i.queue_free()
	var track_render = load("res://dotflow/widgets/timeline/timeline_track_length.tscn").instantiate()
	audio_track.add_child(track_render)
	
	if DotFlow.show.timeline.delay_start > 0.0:
		var panel = PanelContainer.new()
		panel.custom_minimum_size.x = DotFlow.show.timeline.delay_start * 50.0
		timeline.add_child(panel)
	
	for i in timeline_sets.size():
		var timeline_item: TimelineMeasure = load("res://dotflow/widgets/timeline/timeline_measure.tscn").instantiate()
		timeline_item.measure_idx = i
		timeline_item.counts = timeline_sets[i].count
		timeline_item.tempo = timeline_sets[i].tempo
		timeline.add_child(timeline_item)

func _handle_drag(_delta: float):
	if holding_mouse_down:
		DotFlow.playback.set_track_time(clampf(event_position.x / 50, 0.0, float(DotFlow.show.timeline.get_show_duration())))
	pass

var holding_mouse_down: bool = false
var event_position: Vector2

func _on_timeline_timetrack_input(event):
	if event is InputEventMouseButton:
		if event.button_mask == MOUSE_BUTTON_LEFT:
			holding_mouse_down = true
		else:
			holding_mouse_down = false
	if event is InputEventMouseMotion:
		event_position = event.position
