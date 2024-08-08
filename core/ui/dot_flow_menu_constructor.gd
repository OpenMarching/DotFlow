extends Node

func build():
	DFInterface.menu_button_pressed.connect(_handle)
	DFInterface.add_menu_option("File", "Exit Editor")

func _handle(menu, option):
	if menu == "File" and option == "Exit Editor":
		get_tree().quit(0)
