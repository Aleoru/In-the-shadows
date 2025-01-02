extends Node3D

const USER_INTERFACE = "res://assets/GUI/user_interface.tscn"
const LEVEL_1 = "res://assets/scenes/level_1.tscn"
const LEVEL_2 = "res://assets/scenes/level_2.tscn"
const LEVEL_3 = "res://assets/scenes/level_3.tscn"

@onready var animation_node = $AnimationNode as AnimationPlayer

var l1 = false
var l2 = false
var l3 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_level_1_input_event(_camera, _event, _position, _normal, _shape_idx):
	if (Input.is_action_just_pressed("Click")):
		Global.game_controller.change_gui_scene(USER_INTERFACE)
		Global.game_controller.change_3d_scene(LEVEL_1)

func _on_level_2_input_event(_camera, _event, _position, _normal, _shape_idx):
	if (Input.is_action_just_pressed("Click")):
		Global.game_controller.change_gui_scene(USER_INTERFACE)		
		Global.game_controller.change_3d_scene(LEVEL_2)

func _on_level_3_input_event(_camera, _event, _position, _normal, _shape_idx):
	if (Input.is_action_just_pressed("Click")):
		Global.game_controller.change_gui_scene(USER_INTERFACE)
		Global.game_controller.change_3d_scene(LEVEL_3)
