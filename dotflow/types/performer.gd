class_name Performer
extends Node

var available_options = ["type", "label", "name"]

func _init(options: Dictionary = {}):
	for key in options.keys():
		if available_options.has(key):
			if key == "type":
				set_type(options["type"])
			if key == "label":
				set_label(options["label"])
			if key == "name":
				set_name(options["name"])
		else:
			OS.alert("Attempted to set an invalid performer option on initialize.")
	pass

var _type: int
var _label: String
var _perf_name: String
var _sets: Array[PerformerSet]

## type
func get_type() -> int:
	return _type

func set_type(type: int):
	_type = type

## label
func get_label() -> String:
	return _label

func set_label(label: String):
	_label = label

## name
func get_perf_name() -> String:
	return _perf_name

func set_perf_name(perf_name: String):
	_perf_name = perf_name

## sets
func get_sets() -> Array[PerformerSet]:
	return _sets

func _insert_set(idx: int, set_: PerformerSet):
	_sets.insert(idx, set_)

func _update_set(idx: int, options: Dictionary):
	for key in options.keys():
		_sets[idx][key] = options[key]

func _remove_set(idx: int):
	_sets.remove_at(idx)

func _ready():
	_sync_start_sets()

func _sync_start_sets():
	for i in range(DotFlow.show.timeline.get_sets().size()):
		_sets.insert(i, PerformerSet.new(Vector2(i,0),0,0))

func _set_inserted(idx):
	if idx == 0:
		_sets.insert(0, PerformerSet.new(Vector2(1,0),0,0))
	else:
		_sets.insert(idx, _sets[idx - 1])

func _set_deleted(idx):
	_sets.remove_at(idx)

class PerformerSet:
	func _init(loc: Vector2, hei: float, rot: float):
		self.location = loc
		self.height = hei
		self.rotation = rot
	
	var location: Vector2
	var height: float
	var rotation: float
