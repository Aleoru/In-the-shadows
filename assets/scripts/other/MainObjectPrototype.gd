extends MeshInstance3D

var rotating = false
var rotating_z = false

var prev_mouse_position
var next_mouse_position

func _ready():
	randomize()
	var x = randf_range(0, TAU)
	var y = randf_range(0, TAU)
	var z = randf_range(0, TAU)
	rotate_x(x)
	rotate_y(y)
	rotate_z(z)

func _process(delta):
	var cam = get_viewport().get_camera_3d()
	if (Input.is_action_just_pressed("rotate_x_y") and cam.ray_cast()):
		rotating = true
		prev_mouse_position = get_viewport().get_mouse_position()
	elif (Input.is_action_just_released("rotate_x_y")):
		rotating = false
	elif (Input.is_action_just_pressed("rotate_z") and cam.ray_cast()):
		rotating = true
		rotating_z = true
		prev_mouse_position = get_viewport().get_mouse_position()
	elif (Input.is_action_just_released("rotate_z")):
		rotating = false		
		rotating_z = false
	if (rotating):
		rotate_object(delta, rotating_z)
		
func rotate_object(delta, axis):
	next_mouse_position = get_viewport().get_mouse_position()
	var axis_x = Vector3(1, 0, 0)
	var axis_y = Vector3(0, 1, 0)
	var axis_z = Vector3(0, 0, 1)
	if (!axis):
		transform.basis = transform.basis.rotated(axis_x, (next_mouse_position.y - prev_mouse_position.y) * .5 * delta)
		transform.basis = transform.basis.rotated(axis_y, (next_mouse_position.x - prev_mouse_position.x) * .5 * delta)
	else:
		transform.basis = transform.basis.rotated(axis_z, (next_mouse_position.y - prev_mouse_position.y) * .5 * delta)
	prev_mouse_position = next_mouse_position
