class_name DotFlowShowPerformers
extends Node

signal performers_updated
signal selected_performers_updated

var _performers: Array[Performer]

var _selected_performers: Array[Performer]

func get_performer_at(idx: int) -> Performer:
	return _performers[idx]

func get_performers() -> Array[Performer]:
	return _performers

func get_selected_performers() -> Array[Performer]:
	return _selected_performers

func create_performer(performer: Performer = Performer.new()):
	_performers.append(performer)
	performers_updated.emit()

func delete_performer(performer: Performer):
	_performers.erase(performer)
	performers_updated.emit()

func delete_performer_at(idx: int):
	_performers.remove_at(idx)
	performers_updated.emit()

func select_performer(performer: Performer):
	if not _selected_performers.has(performer):
		_selected_performers.append(performer)
	selected_performers_updated.emit()

func select_performer_at(idx: int):
	if not _selected_performers.has(_performers[idx]):
		_selected_performers.append(_performers[idx])
	selected_performers_updated.emit()

func deselect_performer(performer: Performer):
	if _selected_performers.has(performer):
		_selected_performers.erase(performer)
	selected_performers_updated.emit()

func deselect_performer_at(idx: int):
	if _selected_performers.has(_performers[idx]):
		_selected_performers.erase(_performers[idx])
	selected_performers_updated.emit()

func _ready():
	DotFlow.show.timeline.show_set_inserted.connect(_set_inserted)
	DotFlow.show.timeline.show_set_deleted.connect(_set_deleted)
	create_performer(Performer.new({"type":10,"label": "A7"}))

func _set_inserted(idx):
	for i in _performers:
		i._set_inserted(idx)

func _set_deleted(idx):
	for i in _performers:
		i._set_deleted(idx)
