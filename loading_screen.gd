extends Control

@onready var progress_bar = $ProgressBar
@onready var label = $Label

var progress = 0


func _ready():
	progress_bar.value = 0

	# Start loading animation
	var tween = create_tween()
	tween.tween_property(progress_bar, "value", 100, 2.5)

	await tween.finished

	# Go to Level 1
	get_tree().change_scene_to_file(
		"res://Scean/Level/game_scene.tscn"
	)
