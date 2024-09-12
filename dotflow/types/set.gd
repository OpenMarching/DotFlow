class_name Set
extends Node

var time_based: bool

var count: int
var tempo: int

var time: float


## Passed a true or false for if the measure should be time based.
## [codeblock]
## Set.new(true, {time})
## Set.new(false, {count, tempo})
## [/codeblock]
func _init(_time_based: bool, options: Dictionary):
	self.time_based = _time_based
	if _time_based:
		self.time = options["time"]
	else:
		self.count = options["counts"]
		self.tempo = options["tempo"]
