extends CharacterBody2D

# Get the TeacherLabel from the game scene
@onready var teacher_label = get_node("../HUD/TeacherLabel")

# Checks if the player is close enough to the teacher
var player_near = false

# Checks if Level 1 has been completed
var level_complete = false


func _process(_delta):

	# Player is near teacher and presses E
	if player_near and Input.is_action_just_pressed("interact"):

		# Get the Player node
		var player = get_node("../Player")

		# If Level 1 is already complete
		if level_complete:

			# Go to Level 2
			get_tree().change_scene_to_file(
				"res://Scean/Level/level2.tscn"
			)

			return


		# Check if player collected all 3 books
		if player.books_collected >= 3:

			# Level 1 is now complete
			level_complete = true

			# Show success message
			teacher_label.visible = true
			teacher_label.text = "🎉 Good Job! 🎉\nLevel 1 Complete! 🏆\nPress E to continue."

		else:

			# Player hasn't collected all books
			teacher_label.visible = true
			teacher_label.text = "Collect all 3 books first 😡!"


# Player enters teacher's interaction area
func _on_area_2d_body_entered(body):

	if body.name == "Player":
		player_near = true


# Player leaves teacher's interaction area
func _on_area_2d_body_exited(body):

	if body.name == "Player":
		player_near = false

		# Hide message only if Level 1 isn't complete
		if not level_complete:
			teacher_label.visible = false
