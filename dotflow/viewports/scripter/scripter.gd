extends Node

var dir = DirAccess.open("user://")

signal open_files_changed

@onready var tree: Tree = $HSplitContainer/Tree
var directory = "user://scripts"
var root

@onready var tabbar: TabBar = $HSplitContainer/VBoxContainer/HBoxContainer/TabBar
@onready var code: CodeEdit = $HSplitContainer/VBoxContainer/Panel/CodeEdit

var open_files: Array[FileEdit]
var open_files_paths: Array[String]

var first_open := true

func _add_file_to_edit(item: FileEdit):
	open_files.append(item)
	open_files_paths.append(item.path)
	open_files_changed.emit()

func _remove_editing_file(item: FileEdit):
	open_files.erase(item)
	open_files_paths.erase(item.path)
	open_files_changed.emit()
	code.text = ""

func _ready():
	OS.shell_open(OS.get_user_data_dir())
	root = tree.create_item()
	add_files_to_tree(directory, root)
	open_files_changed.connect(_refresh_editors)

func _refresh_editors():
	tabbar.clear_tabs()
	for i in open_files:
		tabbar.add_tab(i.name)

func add_files_to_tree(directory, parent_node):
	var fs = DirAccess.open(directory)
	var files = fs.get_files()
	var dirs = fs.get_directories()

	for file in files:
		var file_path = directory + "/" + file
		var tree_item = tree.create_item(parent_node)
		tree_item.set_text(0, file)
		tree_item.set_metadata(0, file_path)
		tree_item.propagate_check(0, true)

	for dir in dirs:
		var subdir_path = directory + "/" + dir
		var tree_item = tree.create_item(parent_node)
		tree_item.set_text(0, dir)
		tree_item.set_collapsed_recursive(true)
		tree_item.set_metadata(0, "")
		add_files_to_tree(subdir_path, tree_item)


func _on_tree_cell_selected():
	var item = tree.get_selected()
	if item.get_metadata(0) == "":
		return
	var file = FileAccess.open(item.get_metadata(0), FileAccess.READ)
	var content = file.get_as_text()
	var file_edit_item = FileEdit.new(item.get_text(0), item.get_metadata(0), content)
	if not open_files_paths.has(file_edit_item.path):
		_add_file_to_edit(file_edit_item)

class FileEdit:
	var name: String = ""
	var path: String = ""
	var content: String = ""
	
	func _init(_name, _path, _content):
		name = _name
		path = _path
		content = _content

func _set_editor_settings(editor: CodeEdit) -> CodeEdit:
	editor.line_folding = true
	editor.gutters_draw_line_numbers
	editor.wrap_mode = TextEdit.LINE_WRAPPING_BOUNDARY
	return editor

func _on_tab_bar_tab_changed(tab):
	if first_open == false:
		var prev = tabbar.get_tab_title(tabbar.get_previous_tab())
		for i in open_files:
			if i.name == prev:
				i.content = code.text
	first_open = false
	var selected = tabbar.get_tab_title(tab)
	for i in open_files:
		if selected == i.name:
			code.text = i.content


func _on_file_id_pressed(id):
	var item = $HSplitContainer/VBoxContainer/HBoxContainer/MenuBar/File.get_item_text(id)
	var active_file = tabbar.get_tab_title(tabbar.current_tab)
	match item:
		"Save":
			for i in open_files:
				if i.name == active_file:
					var file = FileAccess.open(i.path, FileAccess.WRITE)
					file.store_string(i.content)
		"Save and Close":
			for i in open_files:
				if i.name == active_file:
					var file = FileAccess.open(i.path, FileAccess.WRITE)
					file.store_string(i.content)
					_remove_editing_file(i)
		"Discard and Close":
			for i in open_files:
				if i.name == active_file:
					_remove_editing_file(i)

func _on_new_id_pressed(id):
	var item = $".".get_item_text(id)
	match item:
		"About":
			add_child(load("res://dotflow/windows/about/about.tscn").instantiate())
		"OpenMarching":
			OS.shell_open("https://openmarching.org")


func _on_code_edit_text_changed():
	var active_file = tabbar.get_tab_title(tabbar.current_tab)
	for i in open_files:
		if i.name == active_file:
			i.content = code.text
