extends PanelContainer


func _on_button_pressed():
	DotFlow.show.timeline.insert_measure_at(0, false, {"counts": 8, "tempo": 60})
