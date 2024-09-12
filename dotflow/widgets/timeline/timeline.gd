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
		$HBoxContainer/ScrollContainer.scroll_horizontal = offset * DotFlow.config.get_value("timeline","pixel_per_second") - $HBoxContainer/ScrollContainer.size.x / 2


func _set_local_time(_time: float):
	timecursor.position.x = _time * DotFlow.config.get_value("timeline","pixel_per_second")

func _ready():
	DotFlow.playback.track_time_changed.connect(_set_local_time)
	_refresh_timeline()
	DotFlow.show.timeline.show_duration_changed.connect(_show_duration_changed)
	DotFlow.events.timeline_refreshed.connect(_refresh_timeline)

func _show_duration_changed(_duration: float):
	_refresh_timeline()

var thread

var timesec_ps = load("res://dotflow/widgets/timeline/timeline_second.tscn")
var trackrender_ps = load("res://dotflow/widgets/timeline/timeline_track_length.tscn")
var timelineitem_ps = load("res://dotflow/widgets/timeline/timeline_measure.tscn")

func _refresh_timeline():
	for i in timeline.get_children():
		i.queue_free()
	for i in timetrack.get_children():
		i.queue_free()
	
	for i in range(DotFlow.show.timeline.get_show_duration()):
		var timesec = timesec_ps.instantiate()
		timesec.time = int(i)
		if DotFlow.config.get_value("timeline","pixel_per_second") <= 30 and i % 5 == 0:
			timesec.custom_minimum_size.x = DotFlow.config.get_value("timeline","pixel_per_second") * 5
			timetrack.add_child(timesec)
		if DotFlow.config.get_value("timeline","pixel_per_second") > 30:
			timesec.custom_minimum_size.x = DotFlow.config.get_value("timeline","pixel_per_second")
			timetrack.add_child(timesec)
	
	$HBoxContainer/TimelineZoom/ZoomSlider.value = DotFlow.config.get_value("timeline","pixel_per_second")
	
	var timeline_sets: Array[Set] = DotFlow.show.timeline.get_sets()
	
	var audio_track = $HBoxContainer/ScrollContainer/VBoxContainer/AudioTrack
	for i in audio_track.get_children():
		i.queue_free()
	var track_render = trackrender_ps.instantiate()
	audio_track.add_child(track_render)
	
	if DotFlow.show.timeline.delay_start > 0.0:
		var panel = PanelContainer.new()
		panel.custom_minimum_size.x = DotFlow.show.timeline.delay_start * DotFlow.config.get_value("timeline","pixel_per_second")
		timeline.add_child(panel)
	
	for i in timeline_sets.size():
		var timeline_item: TimelineMeasure = timelineitem_ps.instantiate()
		timeline_item.measure_idx = i
		timeline_item.time_based = timeline_sets[i].time_based
		timeline_item.time = timeline_sets[i].time
		timeline_item.counts = timeline_sets[i].count
		timeline_item.tempo = timeline_sets[i].tempo
		timeline.add_child(timeline_item)

func _handle_drag(_delta: float):
	if holding_mouse_down:
		DotFlow.playback.set_track_time(clampf(event_position.x / DotFlow.config.get_value("timeline","pixel_per_second"), 0.0, float(DotFlow.show.timeline.get_show_duration())))
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

func _zoom_out():
	var pps: float = DotFlow.config.get_value("timeline", "pixel_per_second")
	var added_val = pps - 10
	if added_val < 10:
		return
	DotFlow.config.update_value("timeline", "pixel_per_second", added_val)
	DotFlow.events.timeline_refreshed.emit()

func _zoom_in():
	var pps: float = DotFlow.config.get_value("timeline", "pixel_per_second")
	var added_val = pps + 10
	if added_val > 100:
		return
	DotFlow.config.update_value("timeline", "pixel_per_second", added_val)
	DotFlow.events.timeline_refreshed.emit()



func _on_zoom_slider_drag_ended(value_changed):
	if value_changed == true:
		var zoom = $HBoxContainer/TimelineZoom/ZoomSlider.value
		DotFlow.config.update_value("timeline", "pixel_per_second", zoom)
		DotFlow.events.timeline_refreshed.emit()
