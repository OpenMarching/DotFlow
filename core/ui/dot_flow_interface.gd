class_name DotFlowInterface
extends Node

signal menu_button_pressed(menu: String, option: String)

var menu_bar = HBoxContainer.new()

# Menu Items
const _MENUS: Array[String] = ["File", "Edit", "Tools", "Select", "Performers", "Camera", "Graphics", "Audio", "Help", "Connect", "Advanced"]


func _ready():
	var interface = Control.new()
	interface.set_anchors_preset(Control.PRESET_FULL_RECT)
	var panel = Panel.new()
	panel.set_anchors_preset(Control.PRESET_TOP_WIDE)
	panel.size.y = 32
	panel.mouse_filter = Control.MOUSE_FILTER_STOP
	menu_bar.set_anchors_preset(Control.PRESET_FULL_RECT)
	menu_bar.mouse_filter = Control.MOUSE_FILTER_STOP
	interface.add_child(panel)
	panel.add_child(menu_bar)
	self.add_child(interface)
	
	_build_menu_bar()
	_build_base_menu()


func _build_menu_bar():
	for menu in _MENUS:
		var menu_btn = MenuButton.new()
		menu_btn.text = menu
		menu_btn.name = menu
		menu_bar.add_child(menu_btn)
		menu_bar.get_node(menu).get_popup().connect("id_pressed", func(id): _emit_menu_signal(menu, id))


func _emit_menu_signal(menu: String, id: int):
	var option = menu_bar.get_node(menu).get_popup().get_item_text(id)
	#print("EMIT: option %s in menu %s" % [option,menu])
	menu_button_pressed.emit(menu, option)


## Add a button option to a menu.
func add_menu_option(menu: String, option: String):
	if not _MENUS.has(menu):
		return Utils.alert("Attempted to add a button to a menu that is not available.")
	menu_bar.get_node(menu).get_popup().add_item(option)



func _build_base_menu():
	DFInterface.menu_button_pressed.connect(_base_menu_handle)
	DFInterface.add_menu_option("File", "New Show")
	DFInterface.add_menu_option("File", "Save Show")
	DFInterface.add_menu_option("File", "Open Show")
	DFInterface.add_menu_option("File", "Exit Editor")
	
	DFInterface.add_menu_option("Connect", "OpenMarching")
	
	DFInterface.add_menu_option("Advanced", "Restart Editor")


func _base_menu_handle(menu, option):
	if menu == "File" and option == "New Show":
		OS.alert("New Show")
	if menu == "File" and option == "Save Show":
		DFSaveLoad.save_show()
	if menu == "File" and option == "Open Show":
		DFSaveLoad.load_show()
	if menu == "File" and option == "Exit Editor":
		DFSaveLoad.quit_editor()
	
	if menu == "Connect" and option == "OpenMarching":
		OS.shell_open("https://openmarching.org/")
	
	if menu == "Advanced" and option == "Restart Editor":
		OS.shell_open(OS.get_executable_path())
		get_tree().quit(0)
