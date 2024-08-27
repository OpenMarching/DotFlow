extends Control

var count = 0
var time = 0.0
var tempo = 0

func _ready():
	#self.size = Vector2((60 / tempo) * 50, 0)
	self.custom_minimum_size = Vector2((60 / tempo) * 50, 0)
