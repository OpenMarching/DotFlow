extends Node3D

func _process(delta):
	$CSGBox3D.rotation_degrees.y = $CSGBox3D.rotation_degrees.y + (45 * delta) 
