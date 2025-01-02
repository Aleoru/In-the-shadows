extends Node3D

@export_category("Global variables")
@export var difficulty : int
@export var is_test : bool

@onready var user_interface = $"../../GUI/UserInterface"

var time = 0.0
var stopped = false
var to_drag = false
var to_rot = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if self.name != "Level":
		self.name = "Level"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if stopped:
		return
	time += delta

func reset():
	time = 0.0

func time_to_str() -> String:
	var msec = fmod(time, 1) * 1000
	var sec = fmod(time, 60)
	var minute = time / 60
	var format_str = "%02d : %02d : %02d"
	var return_str = format_str % [minute, sec, msec]
	return return_str

func _on_object_level_finnished():
	stopped = true
	user_interface.show_finnish(is_test, difficulty, time_to_str())
