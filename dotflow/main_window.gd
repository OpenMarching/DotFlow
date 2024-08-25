extends Control

func _ready():
	_on_editor_tab_changed($VBoxContainer/MenuBar/TabBar.current_tab)

func _on_editor_tab_changed(tab):
	for i in $VBoxContainer/Panels.get_children():
		i.visible = false
	
	var selected = $VBoxContainer/MenuBar/TabBar.get_tab_title(tab)
	if selected == "2D Editor":
		$"VBoxContainer/Panels/2D Editor".visible = true
	if selected == "3D Editor":
		$"VBoxContainer/Panels/3D Editor".visible = true
	if selected == "Paper":
		$VBoxContainer/Panels/Paper.visible = true
	if selected == "Preview":
		$VBoxContainer/Panels/Preview.visible = true
