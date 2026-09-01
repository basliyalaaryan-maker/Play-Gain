extends Control


# Get the buttons from the scene
@onready var try_again_button = $TryAgainButton
@onready var quit_button = $QuitButton


func _ready():

	# Connect the buttons
	try_again_button.pressed.connect(_on_try_again_pressed)
	quit_button.pressed.connect(_on_quit_pressed)


# Try Again button
func _on_try_again_pressed():

	# Restart Level 2
	get_tree().change_scene_to_file(
		"res://Scean/Level/level2.tscn"
	)


# Exit button
func _on_quit_pressed():

	# Close the game
	get_tree().quit()
