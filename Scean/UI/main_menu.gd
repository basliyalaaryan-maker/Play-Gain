extends Control

@onready var start_button = $VBoxContainer/StartButton
@onready var quit_button = $VBoxContainer/QuitButton


func _ready():
	start_button.pressed.connect(_on_start_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)

	# Hide the actual buttons because the buttons are already
	# part of the background image
	start_button.modulate.a = 0.0
	quit_button.modulate.a = 0.0


func _on_start_button_pressed():
	print("START GAME CLICKED")

	get_tree().change_scene_to_file(
		"res://loading_screen.tscn"
	)


func _on_quit_button_pressed():
	print("QUIT CLICKED")
	get_tree().quit()
