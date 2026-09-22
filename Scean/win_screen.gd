extends Control

@onready var play_again_button = $PlayAgainButton
@onready var quit_button = $QuitButton


func _ready():
	play_again_button.pressed.connect(_on_play_again_pressed)
	quit_button.pressed.connect(_on_quit_pressed)


# Play Again button
func _on_play_again_pressed():
	animate_button(play_again_button)

	await get_tree().create_timer(0.15).timeout

	get_tree().change_scene_to_file(
		"res://Scean/Level/game_scene.tscn"
	)


# Quit button
func _on_quit_pressed():
	animate_button(quit_button)

	await get_tree().create_timer(0.15).timeout

	get_tree().quit()


# Button click animation
func animate_button(button):
	var original_scale = button.scale

	var tween = create_tween()

	# Shrink
	tween.tween_property(
		button,
		"scale",
		original_scale * 0.85,
		0.07
	)

	# Pop back
	tween.tween_property(
		button,
		"scale",
		original_scale,
		0.08
	)
