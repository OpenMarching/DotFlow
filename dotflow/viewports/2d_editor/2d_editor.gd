extends Node

@onready var start_pos = $Sprite2D.position

var direction = 1.0

func _process(delta):
	$Sprite2D.position.y = $Sprite2D.position.y + direction * delta * 75
	
	if $Sprite2D.position.y > start_pos.y + 50:
		direction = -1.0
	
	if $Sprite2D.position.y < start_pos.y - 50:
		direction = 1.0
