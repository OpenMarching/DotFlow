class_name DotFlowShow
extends Node
## Dot Flow Show Core Class

var title: String = "My New Show"
var subtitle: String = "Made With DotFlow"
var designer: String = "Your Name"
var copyright: String = "© Copyright %s" % Time.get_date_dict_from_system().year

## Provided Audio Track 
var audio_track: AudioStream

var default_tempo: int = 60
var sets: Array[DrillSet]

## Array of the performers, in the show
var performers: Array[DotFlowPerformer]

## The base object for a set, contains the id and the counts.
class DrillSet:
	func _init(_counts = 0, _tempo = 60):
		self.counts = _counts
		self.tempo = _tempo
	
	var id: String = Utils.generate_random_string(15)
	var tempo: int = 60
	var counts: int = 0
	var additional_info: String = ""
