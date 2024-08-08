class_name DotFlowAboutWindow
extends Node

var window: Window

func _ready():
	window = Window.new()
	var container = VBoxContainer.new()
	container.set_anchors_preset(Control.PRESET_FULL_RECT)
	window.add_child(container)
