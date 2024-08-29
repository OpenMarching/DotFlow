extends Window


func _ready():
	pass # Replace with function body.


func _on_close_requested():
	self.queue_free()
