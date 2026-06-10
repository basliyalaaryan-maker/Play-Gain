extends CharacterBody2D

# Checks if the player is close enough to talk to the teacher
var player_near = false


func _process(_delta):

	# If player is near the teacher and presses E
	if player_near and Input.is_action_just_pressed("interact"):

		# Find the Player node
		var player = get_node("../Player")

		# Check how many books have been collected
		if player.books_collected >= 3:
			print("Teacher: Good job!")
			print("Level 1 Complete!")

			# Later we can load Level 2 here
			# get_tree().change_scene_to_file("res://Scean/Level/level2.tscn")

		else:
			print("Teacher: Collect all 3 books!")


# Runs when something enters the teacher's Area2D
func _on_area_2d_body_entered(body):

	# Check if it is the player
	if body.name == "Player":
		player_near = true


# Runs when something leaves the teacher's Area2D
func _on_area_2d_body_exited(body):

	# Check if it is the player
	if body.name == "Player":
		player_near = false
