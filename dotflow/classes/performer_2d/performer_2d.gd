class_name Performer2D
extends Node2D

var performer_idx: int

func _ready():
	DotFlow.show.performers.selected_performers_updated.connect(_selected_performers_updated)
	var perf_ref = DotFlow.show.performers.get_performers()[performer_idx]
	$Label.text = perf_ref.get_label()

func _selected_performers_updated():
	$SelectedSprite.visible = DotFlow.show.performers.get_selected_performers().has(DotFlow.show.performers.get_performers()[performer_idx])

func _toggle_performer_selection():
	if DotFlow.show.performers.get_selected_performers().has(DotFlow.show.performers.get_performers()[performer_idx]):
		DotFlow.show.performers.deselect_performer_at(performer_idx)
	else:
		DotFlow.show.performers.select_performer_at(performer_idx)
