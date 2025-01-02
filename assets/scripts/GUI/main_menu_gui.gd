class_name MainMenu
extends Control

@onready var main_menu = $"../../World3D/MainMenu" as Node3D
@onready var normal_mode = $"MarginContainer/HBoxContainer/VBoxContainer/Normal mode" as Button
@onready var test_mode = $"MarginContainer/HBoxContainer/VBoxContainer/Test mode" as Button
@onready var quit = $MarginContainer/HBoxContainer/VBoxContainer/Quit as Button

func _ready():
	self.visible = true

func _on_normal_mode_pressed():
	self.visible = false
	main_menu.animation_node.play("change_menu")
	await main_menu.animation_node.animation_finished
	Global.game_controller.change_gui_scene("res://assets/GUI/level_selector.tscn")

func _on_test_mode_pressed():
	Global.game_controller.change_gui_scene("res://assets/GUI/user_interface.tscn")
	Global.game_controller.change_3d_scene("res://assets/scenes/TestLevel.tscn")

func _on_quit_pressed():
	get_tree().quit()
