extends CharacterBody2D

# Get the TeacherLabel from the game scene
@onready var teacher_label = get_node("../HUD/TeacherLabel")

# Checks if the player is close enough to the teacher
var player_near = false


func _process(_delta):

	# If the player is near the teacher and presses E
	if player_near and Input.is_action_just_pressed("interact"):

		# Get the Player node
		var player = get_node("../Player")

		# Check if the player has collected all 3 books
		if player.books_collected >= 3:

			# Show success message
			teacher_label.visible = true
			teacher_label.text = "🎉Good Job!🎉\nLevel 1 Complete!🏆\nPress E to continue."

			# Later we can load Level 2 here
			# get_tree().change_scene_to_file("res://Scean/Level/level2.tscn")

		else:

			# Tell the player to collect all books
			teacher_label.visible = true
			teacher_label.text = "Collect all 3 books first😡!"


# Runs when the player enters the teacher's Area2D
func _on_area_2d_body_entered(body):

	if body.name == "Player":
		player_near = true


# Runs when the player leaves the teacher's Area2D
func _on_area_2d_body_exited(body):

	if body.name == "Player":
		player_near = false

		# Hide the message
		teacher_label.visible = false
