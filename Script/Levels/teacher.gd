extends CharacterBody2D

# Checks if the player is close enough to talk to the teacher
var player_near = false


func _process(_delta):

	# If player is near the teacher and presses E
	if player_near and Input.is_action_just_pressed("interact"):
		print("Teacher: Collect all 3 books!")


# Runs when something enters the teacher's Area2D
func _on_area_2d_body_entered(body):

	# Check if it is the player
	if body.name == "Player":

		# Allow interaction with teacher
		player_near = true


# Runs when something leaves the teacher's Area2D
func _on_area_2d_body_exited(body):

	# Check if it is the player
	if body.name == "Player":

		# Stop interaction with teacher
		player_near = false
