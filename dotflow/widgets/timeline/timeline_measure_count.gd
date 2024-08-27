extends Control

var count = 0
var time = 0.0

func _ready():
	$Button.text = str(count)
