extends Control

func _ready():
	_on_editor_tab_changed($VBoxContainer/MenuBar/TabBar.current_tab)

func _on_editor_tab_changed(tab):
	for i in $VBoxContainer/HSplitContainer/Panels.get_children():
		i.visible = false
	
	var selected = $VBoxContainer/MenuBar/TabBar.get_tab_title(tab)
	if selected == "2D Editor":
		DotFlow.state.active_tab = DotFlowState.WindowTabs.TWO_EDITOR
		$"VBoxContainer/HSplitContainer/Panels/2D Editor".visible = true
	if selected == "3D Editor":
		$"VBoxContainer/HSplitContainer/Panels/3D Editor".visible = true
		DotFlow.state.active_tab = DotFlowState.WindowTabs.THREE_EDITOR
	if selected == "Paper":
		$VBoxContainer/HSplitContainer/Panels/Paper.visible = true
		DotFlow.state.active_tab = DotFlowState.WindowTabs.PAPER
	if selected == "Preview":
		$VBoxContainer/HSplitContainer/Panels/Preview.visible = true
		DotFlow.state.active_tab = DotFlowState.WindowTabs.PREVIEW
	if selected == "Scripter":
		$VBoxContainer/HSplitContainer/Panels/Scripter.visible = true
		DotFlow.state.active_tab = DotFlowState.WindowTabs.SCRIPTER
