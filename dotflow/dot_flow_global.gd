class_name DotFlowGlobal
extends Node



var config: DotFlowConfig = DotFlowConfig.new()
var state: DotFlowState = DotFlowState.new()
var events: DotFlowEvents = DotFlowEvents.new()
var show: DotFlowShow = DotFlowShow.new()
var playback: DotFlowPlayback = DotFlowPlayback.new()

func _ready():
	var instances = [config, state, events, show, playback]
	for i in instances:
		self.add_child(i, true)

