class_name LevelSelector
extends Control

@onready var main_menu = $"../../World3D/MainMenu" as Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = true

func _on_back_pressed():
	main_menu.animation_node.play_backwards("change_menu")
	self.visible = false
	await main_menu.animation_node.animation_finished
	Global.game_controller.change_gui_scene("res://assets/GUI/main_menu_gui.tscn")
