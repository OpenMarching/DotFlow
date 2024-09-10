class_name Toaster
extends Node

signal toast_items_changed

var _toasts: Array[ToastItem]

func get_toasts():
	return _toasts

func _add_to_array(item: ToastItem):
	_toasts.append(item)
	toast_items_changed.emit()

func _remove_from_array(item: ToastItem):
	_toasts.erase(item)
	toast_items_changed.emit()

func message(message: String, time: float = 5):
	var tst = ToastItem.new()
	tst.text = message
	tst.time = time
	tst.type = "info"
	_add_to_array(tst)

class ToastItem:
	var text: String
	var type: String
	var time: float

func _process(delta):
	for i in _toasts:
		i.time = i.time - delta
		if i.time <= 0:
			_remove_from_array(i)
