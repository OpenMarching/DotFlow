extends Node
## handles all runtime logic, nothing here persists 

func _process(delta):
	$Selected.visible = DFEditor.selected_performers.has(self)

func _next_position(show: bool):
	pass

func _prev_position(show: bool):
	pass
