class_name DotFlowCamera
extends Node3D

@onready var topdown_camera = Camera3D.new()
@onready var perspective_camera = Camera3D.new()
@onready var innergimbal = Node3D.new()


@export var max_zoom = 10.0
@export var min_zoom = 0.4
@export var zoom_speed = 0.25
var zoom = 1.5

@export var speed = 0.3
@export var drag_speed = 0.005
@export var acceleration = 0.08
@export var mouse_sensitivity = 0.005

var move = Vector3()

func _ready():
	self.add_child(topdown_camera)
	self.add_child(innergimbal)
	innergimbal.add_child(perspective_camera)
	topdown_camera.rotation_degrees = Vector3(-90,0,0)
	topdown_camera.position = Vector3(0,20,0)
	perspective_camera.position = Vector3(0,6,14)
	perspective_camera.rotation_degrees = Vector3(-15,0,0)
	perspective_camera.make_current()

func _input(event):
	if Input.is_action_pressed("rotate_cam"):
		if event is InputEventMouseMotion:
			if event.relative.x != 0:
				innergimbal.rotate_object_local(Vector3.UP, -event.relative.x * mouse_sensitivity)
			if event.relative.y != 0:
				var y_rotation = clamp(-event.relative.y, -30, 30)
				innergimbal.rotate_object_local(Vector3.RIGHT, y_rotation * mouse_sensitivity)
	if Input.is_action_pressed("move_cam"):
		if event is InputEventMouseMotion:
			move.x -= event.relative.x * drag_speed
			move.z -= event.relative.y * drag_speed
	
	if event.is_action_pressed("zoom_in"):
		zoom -= zoom_speed
	if event.is_action_pressed("zoom_out"):
		zoom += zoom_speed
	zoom = clamp(zoom, min_zoom, max_zoom)
	
	if Input.is_action_just_pressed("camera_one"):
		perspective_camera.make_current()
	if Input.is_action_just_pressed("camera_topdown"):
		topdown_camera.make_current()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#zoom camera
	scale = lerp(scale, Vector3.ONE * zoom, zoom_speed)
	#clamp rotation
	innergimbal.rotation.x = clamp(innergimbal.rotation.x, -1.1, 0.3)
	innergimbal.rotation.z = 0
	#move camera
	move_cam(delta)

func move_cam(delta):
	#get inputs
	if Input.is_action_pressed("move_forward"):
		move.z = lerpf(move.z,-speed, acceleration)
	elif Input.is_action_pressed("move_backward"):
		move.z = lerpf(move.z,speed, acceleration)
	else:
		move.z = lerpf(move.z, 0, acceleration)
	if Input.is_action_pressed("move_left"):
		move.x = lerpf(move.x,-speed, acceleration)
	elif Input.is_action_pressed("move_right"):
		move.x = lerpf(move.x,speed, acceleration)
	else:
		move.x = lerpf(move.x, 0, acceleration)
		
	self.position += move.rotated(Vector3.UP,self.rotation.y) * zoom
