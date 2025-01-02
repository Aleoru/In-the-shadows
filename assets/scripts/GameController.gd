class_name GameController extends Node

@export var world_3d : Node3D
@export var world_2d : Node2D
@export var gui : Control

var current_3d_scene
var current_2d_scene
var current_gui_scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.game_controller = self
	current_3d_scene = $World3D/MainMenu
	current_gui_scene = $GUI/MainMenuGUI

## Change scenes functions, they allow you to change in several modes to gain
## flexibility and a better use of resources.

func change_3d_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
	if current_3d_scene != null:
		if delete:
			current_3d_scene.queue_free() # Removes node entirely
			current_3d_scene = null
		elif keep_running:
			current_3d_scene.visible = false # Keeps in memory and running
		else:
			world_3d.remove_child(current_3d_scene) # Keeps in memory, does not run
	await get_tree().process_frame
	call_deferred("_load_3d_scene", new_scene)

func change_2d_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
	if current_2d_scene != null:
		if delete:
			current_2d_scene.queue_free()
			current_2d_scene = null
		elif keep_running:
			current_2d_scene.visible = false
		else:
			world_2d.remove_child(current_2d_scene)
	await get_tree().process_frame
	var new = load(new_scene).instantiate()
	if new:
		world_2d.add_child(new)
	current_2d_scene = new

func change_gui_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
	if current_gui_scene != null:
		if delete:
			current_gui_scene.queue_free()
			current_gui_scene = null
		elif keep_running:
			current_gui_scene.visible = false
		else:
			gui.remove_child(current_gui_scene)
	await get_tree().process_frame
	var new = load(new_scene).instantiate()
	gui.add_child(new)
	current_gui_scene = new

func _load_3d_scene(new_scene):
	var new = load(new_scene).instantiate()	
	world_3d.add_child(new)
	current_3d_scene = new

### General purpose functions

var paused = false

func pauseGame():
	if paused:
		Engine.time_scale = 1
	else:
		Engine.time_scale = 0
	paused = !paused 

