extends Control

func _ready():
	_on_editor_tab_changed($VBoxContainer/MenuBar/TabBar.current_tab)
	$VBoxContainer/VSplitContainer.offset_top = 100

func _on_editor_tab_changed(tab):
	for i in $VBoxContainer/VSplitContainer/HSplitContainer/Panels.get_children():
		i.visible = false
	
	var selected = $VBoxContainer/MenuBar/TabBar.get_tab_title(tab)
	if selected == "2D Editor":
		DotFlow.state.active_tab = DotFlowState.WindowTabs.TWO_EDITOR
		$"VBoxContainer/VSplitContainer/HSplitContainer/Panels/2D Editor".visible = true
	if selected == "3D Editor":
		$"VBoxContainer/VSplitContainer/HSplitContainer/Panels/3D Editor".visible = true
		DotFlow.state.active_tab = DotFlowState.WindowTabs.THREE_EDITOR
	if selected == "Paper":
		$VBoxContainer/VSplitContainer/HSplitContainer/Panels/Paper.visible = true
		DotFlow.state.active_tab = DotFlowState.WindowTabs.PAPER
	if selected == "Preview":
		$VBoxContainer/VSplitContainer/HSplitContainer/Panels/Preview.visible = true
		DotFlow.state.active_tab = DotFlowState.WindowTabs.PREVIEW
	if selected == "Scripter":
		$VBoxContainer/VSplitContainer/HSplitContainer/Panels/Scripter.visible = true
		DotFlow.state.active_tab = DotFlowState.WindowTabs.SCRIPTER


func _on_panel_toggle_toggled(toggled_on):
	$VBoxContainer/VSplitContainer/BottomPanePanels.visible = toggled_on


func _on_tab_bar_tab_changed(tab):
	for i in $VBoxContainer/VSplitContainer/BottomPanePanels.get_children():
		i.visible = false
	
	var selected = $VBoxContainer/HBoxContainer/HBoxContainer/BottomPanelTabBar.get_tab_title(tab)
	if selected == "Timeline":
		$VBoxContainer/VSplitContainer/BottomPanePanels/Timeline.visible = true
