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
