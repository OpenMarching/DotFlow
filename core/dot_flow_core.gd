class_name DotFlowCore
extends Node

signal active_state_changed(new_state: AppState)
signal open_show_changed(new_show: DotFlowShow)

enum AppState {
	BLANK,
	STATIC,
	MODIFYING,
	PREVIEWING,
	PLAYBACK
}

var active_state: AppState = AppState.BLANK:
	set(state):
		active_state_changed.emit(state)

var open_show: DotFlowShow = null:
	set(value):
		open_show_changed.emit(value)
		if value == null:
			performers = []

var performers: Array[DotFlowPerformer] = []


func _ready():
	for i in range(5):
		var performer: DotFlowPerformer = DotFlowPerformer.new()
		performers.append(performer) # Must be called first to ensure perfomer class is added script wise before being intanciated into the world
		self.add_child(performer, true)
		performer.get_child(0).position = Vector3(i * 0.625,0,8 * -.625)
