extends Node

@onready var toaster = $VBoxContainer

func _ready():
	Toast.toast_items_changed.connect(_toasts_changed)

var toast_panel = load("res://dotflow/widgets/toaster/toaster_item.tscn")

func _toasts_changed():
	for i in toaster.get_children():
		i.queue_free()
	
	for i in Toast.get_toasts():
		var item = toast_panel.instantiate()
		item.text = i.text
		toaster.add_child(item)
