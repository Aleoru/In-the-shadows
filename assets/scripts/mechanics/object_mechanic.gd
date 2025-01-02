extends MeshInstance3D

signal level_finnished

@export_category("Global Variables")
@export var min_x : float
@export var max_x : float
@export var min_y : float
@export var max_y : float
@export var is_selected : bool

@onready var level = get_tree().current_scene.get_node('World3D/Level')

var rotating_x = false
var rotating_y = false
var prev_mouse_position
var next_mouse_position
var rot_correct = false
var object

func _ready():
	randomize()
	var x = randf_range(0, TAU)
	var y = randf_range(0, TAU)
	if (level.difficulty >= 1):
		rotate_x(x)
	if (level.difficulty >= 2):
		rotate_y(y)
	if (level.difficulty >= 3):
		object = $"../Object"
	

func _process(delta):
	var cam = get_viewport().get_camera_3d()
	if level.difficulty >= 3:
		if object.dragging:
			return
	if is_selected:
		if Input.is_action_just_pressed("rotate_x") and cam.ray_cast() and level.difficulty >= 1:
			rotating_x = true
			prev_mouse_position = get_viewport().get_mouse_position()
		elif Input.is_action_just_pressed("rotate_y") and cam.ray_cast() and level.difficulty >= 2:
			rotating_y = true
			prev_mouse_position = get_viewport().get_mouse_position()
		elif Input.is_action_just_released("rotate_x") or Input.is_action_just_released("rotate_y"):
			rotating_x = false
			rotating_y = false
		if rotating_x or rotating_y:
			rotate_object(delta)

func rotate_object(delta):
	next_mouse_position = get_viewport().get_mouse_position()
	var axis_x = Vector3(1, 0, 0)
	var axis_y = Vector3(0, 1, 0)
	if rotating_x:
		transform.basis = transform.basis.rotated(axis_x, (next_mouse_position.y - prev_mouse_position.y) * .5 * delta)
	elif rotating_y:
		transform.basis = transform.basis.rotated(axis_y, (next_mouse_position.x - prev_mouse_position.x) * .5 * delta)
	prev_mouse_position = next_mouse_position
	check_rotation()

func check_rotation():
	var x_in_range = false
	var y_in_range = false
	var x = self.rotation.x
	if x >= min_x and x <= max_x:
		x_in_range = true
	var y = self.rotation.y
	if y >= min_y and y <= max_y:
		y_in_range = true
	if x_in_range and y_in_range:
		rot_correct = true
		if not get_parent() is Area3D:
			level_finnished.emit()
