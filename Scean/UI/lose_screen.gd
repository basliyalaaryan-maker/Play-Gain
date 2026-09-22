extends Control


# Get the buttons from the scene
@onready var play_again_button = $PlayAgainButton
@onready var quit_button = $QuitButton


func _ready():

	# Connect the buttons
	play_again_button.pressed.connect(_on_play_again_pressed)
	quit_button.pressed.connect(_on_quit_pressed)


# Play Again button
func _on_play_again_pressed():

	# Restart Level 2
	get_tree().change_scene_to_file(
		"res://Scean/Level/level2.tscn"
	)


# Quit button
func _on_quit_pressed():

	# Close the game
	get_tree().quit()
