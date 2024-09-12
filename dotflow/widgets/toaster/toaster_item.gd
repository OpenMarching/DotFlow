extends Node

var type: String = "info"

var text: String = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBox/HBox/Label.text = text
	
