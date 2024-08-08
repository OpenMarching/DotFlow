class_name DotFlowSaveLoad
extends Node


func quit_editor():
	if DFCore.open_show == null:
		get_tree().quit(0)
	else:
		var dialog = ConfirmationDialog.new()
		dialog.title = "Confirm Close"
		dialog.dialog_text = "A Show Is Currently Open, Are you sure you want to quit?"
		dialog.visible = true
		dialog.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
		dialog.confirmed.connect(func(): get_tree().quit(0))
		dialog.canceled.connect(func(): dialog.queue_free())
		DFInterface.add_child(dialog)


func save_show():
	if DFCore.open_show == null:
		OS.alert("No Show Is Open To Save.")
	else:
		OS.alert("Show Saved")


func load_show():
	if DFCore.open_show != null:
		var dialog = ConfirmationDialog.new()
		dialog.title = "Confirm Open"
		dialog.dialog_text = "A Show Is Currently Open, Are you sure you want to open a new show?"
		dialog.visible = true
		dialog.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
		dialog.confirmed.connect(func(): get_tree().quit(0))
		dialog.canceled.connect(func(): dialog.queue_free())
		DFInterface.add_child(dialog)
	else:
		OS.alert("Open Show")
