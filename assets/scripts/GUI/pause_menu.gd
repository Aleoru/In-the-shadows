extends Control

@export_group("Global Variables")
@export var user_interface : String
@export var main_menu_gui : String
@export var main_menu : String

func _ready():
	self.visible = true

func _on_continue_pressed():
	Global.game_controller.change_gui_scene(user_interface, false, true)
	Global.game_controller.pauseGame()

func _on_back_to_menu_pressed():
	Global.game_controller.pauseGame()
	Global.game_controller.change_3d_scene(main_menu)
	Global.game_controller.change_gui_scene(main_menu_gui)
