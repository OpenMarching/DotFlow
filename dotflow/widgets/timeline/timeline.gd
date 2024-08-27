class_name Timeline
extends Control

@onready var timeline = $HBoxContainer/ScrollContainer/VBoxContainer/TimelineMeasures
@onready var timetrack = $HBoxContainer/ScrollContainer/VBoxContainer/TimeSequence
@onready var timecursor = $HBoxContainer/ScrollContainer/VBoxContainer/Control/Cursor

var time = 0.0

func _process(delta):
	_handle_drag(delta)


func _set_local_time(time: float):
	timecursor.position.x = time * 50

func _ready():
	DotFlow.playback.track_time_changed.connect(_set_local_time)
	_refresh_timeline()
	DotFlow.show.timeline.show_duration_changed.connect(_show_duration_changed)

func _show_duration_changed(duration: float):
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
	
	for i in DotFlow.show.timeline.get_sets():
		var timeline_item: TimelineMeasure = load("res://dotflow/widgets/timeline/timeline_measure.tscn").instantiate()
		timeline_item.counts = i.count
		timeline_item.tempo = i.tempo
		timeline.add_child(timeline_item)

func _handle_drag(delta: float):
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
