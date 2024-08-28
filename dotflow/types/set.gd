class_name Set
extends Node

var count: int
var tempo: int

var _start_time: float
var _set_length: float

func _init(count: int, tempo: int):
	self.count = count
	self.tempo = tempo
