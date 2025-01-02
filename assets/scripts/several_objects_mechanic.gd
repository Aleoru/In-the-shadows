extends Node3D

signal level_finnished

const LONG_PRESS_THRESHOLD = 300 #miliseconds

@export_category("Global Variables")
@export var min_x : float
@export var max_x : float
@export var min_y : float
@export var max_y : float

@onready var one = $"../One"
@onready var two = $"../Two"
@onready var level = get_tree().current_scene.get_node('World3D/Level')
@onready var camera_3d = get_tree().current_scene.get_node('World3D/Level/Camera3D')

var dragging = false
var init_mouse_position
var prev_mouse_position
var next_mouse_position
var last_pressed_time = 0
var pos_correct = false

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var x_or_y = randi_range(1, 2)
	var x = randf_range(0, TAU)
	var y = randf_range(0, TAU)
	print(x_or_y)
	if x_or_y == 1:
		rotate_x(x)	
	else:
		rotate_y(y)
	one.is_selected = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("drag_object"):
		last_pressed_time = Time.get_ticks_msec()
		dragging = true
		prev_mouse_position = get_viewport().get_mouse_position()
	elif Input.is_action_just_released("drag_object"):
		var elapsed_time = Time.get_ticks_msec() - last_pressed_time
		dragging = false
		if elapsed_time < LONG_PRESS_THRESHOLD:
			print("Selecting object...")
			select_object()
	if dragging:
		drag_object(delta)
	check_all_finnished()

func drag_object(delta):
	next_mouse_position = get_viewport().get_mouse_position()
	var axis_x = Vector3(1, 0, 0)
	var axis_y = Vector3(0, 1, 0)
	transform.basis = transform.basis.rotated(axis_x, (next_mouse_position.y - prev_mouse_position.y) * .5 * delta)
	transform.basis = transform.basis.rotated(axis_y, (next_mouse_position.x - prev_mouse_position.x) * .5 * delta)
	prev_mouse_position = next_mouse_position
	check_position()

func check_position():
	var x_in_range = false
	var y_in_range = false
	var x = self.rotation.x
	if x >= min_x and x <= max_x:
		x_in_range = true
	var y = self.rotation.y
	if y >= min_y and y <= max_y:
		y_in_range = true
	if x_in_range and y_in_range:
		pos_correct = true

func select_object():
	one.is_selected = !one.is_selected
	two.is_selected = !two.is_selected
	print("one: ", one.is_selected)
	print("two: ", two.is_selected)

func check_all_finnished():
	if pos_correct and one.rot_correct and two.rot_correct:
		level_finnished.emit()
