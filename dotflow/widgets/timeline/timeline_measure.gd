class_name TimelineMeasure
extends Control

var counts: int
var tempo: int

var counts_box
var label

func _init(_counts: int = 8, _tempo: int = 120):
	counts = _counts
	tempo = _tempo

func _ready():
	_create_ui()
	for i in range(counts):
		var btn = Button.new()
		btn.text = str(i)
		counts_box.add_child(btn)
	label.text = "%s @ %s bmp" % [self.counts, self.tempo]

func _create_ui():
	var panel = PanelContainer.new()
	var vert = VBoxContainer.new()
	counts_box = HBoxContainer.new()
	label = Label.new()
	vert.add_child(counts_box)
	vert.add_child(label)
	panel.add_child(vert)
	self.add_child(panel)
