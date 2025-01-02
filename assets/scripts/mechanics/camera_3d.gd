extends Camera3D

const RAY_LENGTH = 1000
var dragging = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (Input.is_action_just_pressed("drag_object")):
		ray_cast()
		dragging = true
	elif (Input.is_action_just_released("drag_object")):
		dragging = false

func ray_cast():
	var space_state = get_world_3d().direct_space_state
	var cam = $"."
	var mousepos = get_viewport().get_mouse_position()
	var origin = cam.project_ray_origin(mousepos)
	var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
	result = result.get("collider")
	if (result):
		return true
	else:
		return false
