class_name DotFlowShow
extends Node

var show_open: bool = false
var performers = DotFlowShowPerformers.new()
var timeline = DotFlowShowTimeline.new()
var audio = DotFlowShowAudio.new()

func _ready():
	var instances = [performers, timeline, audio]
	for i in instances:
		self.add_child(i, true)
