extends Control

const FILE_BEGIN = "res://assets/scenes/level_"
const FILE_END = ".tscn"

@export_group("Global Variables")
@export var pause_menu : String

@onready var win_container = $MarginContainer/WinContainer
@onready var next_level = $MarginContainer/WinContainer/WinScreen/GridContainer/NextLevel
@onready var try_again = $MarginContainer/WinContainer/WinScreen/GridContainer/TryAgain
@onready var stopwatch_label = $MarginContainer/WinContainer/WinScreen/StopwatchLabel

var test_level_path = "res://assets/scenes/TestLevel.tscn"
var main_menu_path = "res://assets/scenes/MainMenu.tscn"
var menu_gui_path = "res://assets/GUI/main_menu_gui.tscn"
var user_interface_path = "res://assets/GUI/user_interface.tscn"	
var next_level_path


func _ready():
	self.visible = true
	next_level.visible = false
	try_again.visible = false

func _on_pause_pressed():
	Global.game_controller.change_gui_scene(pause_menu, false, true)
	Global.game_controller.pauseGame()

func show_finnish(test : bool, actual_level : int, time : String):
	stopwatch_label.text = time
	if test:
		try_again.show()
	else:
		next_level.show()
		next_level_path = FILE_BEGIN + str(actual_level + 1) + FILE_END
	win_container.show()

func _on_next_level_pressed():
	win_container.hide()
	next_level.hide()
	Global.game_controller.change_3d_scene(next_level_path)

func _on_try_again_pressed():
	win_container.hide()
	try_again.hide()
	Global.game_controller.change_3d_scene(test_level_path)

func _on_back_to_menu_pressed():
	Global.game_controller.change_3d_scene(main_menu_path)
	Global.game_controller.change_gui_scene(menu_gui_path)

