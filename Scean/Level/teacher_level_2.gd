extends CharacterBody2D


# Teacher's animated sprite
@onready var animated_sprite = $AnimatedSprite2D


# Player reference
var player = null


# Teacher movement speed
var speed = 80.0


# Number of books needed to finish Level 2
var total_books = 8


# Stops the completion message from repeatedly appearing
var game_complete = false


# Time between teacher attacks
var attack_cooldown = 1.0

# Tracks the attack cooldown
var attack_timer = 0.0


func _ready():

	# Find the player in the player group
	player = get_tree().get_first_node_in_group("player")

	# Start with the Idle animation
	animated_sprite.play("Idle")


func _physics_process(delta):

	# If we can't find the player, try again
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		return


	# Count down the attack cooldown
	if attack_timer > 0:
		attack_timer -= delta


	# Get the number of books collected
	var books = player.books_collected


	# Calculate distance between teacher and player
	var distance = global_position.distance_to(player.global_position)


	# ------------------------------------------------
	# PLAYER HAS COLLECTED ALL 8 BOOKS
	# ------------------------------------------------

	if books >= total_books:

		# If the player is close enough to the teacher
		if distance < 70:

			# Stop the teacher
			velocity = Vector2.ZERO

			# Play Idle animation
			animated_sprite.play("Idle")


			# Only show the completion message once
			if not game_complete:

				game_complete = true

				# Find TeacherLabel inside the HUD
				var teacher_label = get_node_or_null("../HUD/TeacherLabel")

				if teacher_label:
					teacher_label.visible = true
					teacher_label.text = "Good Job! You completed the game!\nPress E to Play Again\nPress Q to Exit"


			# ----------------------------------------
			# PRESS E TO PLAY AGAIN
			# ----------------------------------------

			if Input.is_action_just_pressed("interact"):

				get_tree().change_scene_to_file(
					"res://Scean/Level/game_scene.tscn"
				)


			# ----------------------------------------
			# PRESS Q TO EXIT
			# ----------------------------------------

			if Input.is_action_just_pressed("quit_game"):

				get_tree().quit()


		else:

			# All books collected, but player hasn't
			# reached the teacher yet.

			var direction = global_position.direction_to(
				player.global_position
			)

			velocity = direction * speed

			# Teacher runs toward player
			animated_sprite.play("Run")

			move_and_slide()

		return


	# ------------------------------------------------
	# PLAYER HAS NOT COLLECTED ALL 8 BOOKS
	# ------------------------------------------------


	# If player is very close
	if distance < 50:

		# Stop moving
		velocity = Vector2.ZERO

		# Play attack animation
		animated_sprite.play("Attack")


		# Damage the player once every second
		if attack_timer <= 0:

			# Get the Level 2 scene
			var level = get_tree().current_scene

			# Remove 10 health
			level.damage_player(10)

			# Reset attack timer
			attack_timer = attack_cooldown


	# If player is nearby
	elif distance < 200:

		# Move toward the player
		var direction = global_position.direction_to(
			player.global_position
		)

		velocity = direction * speed

		# Play running animation
		animated_sprite.play("Run")

		# Move the teacher
		move_and_slide()


	# If player is far away
	else:

		# Stay still
		velocity = Vector2.ZERO

		# Play Idle animation
		animated_sprite.play("Idle")


# ------------------------------------------------
# PLAYER ENTERS THE INTERACTION AREA
# ------------------------------------------------

func _on_interaction_area_body_entered(body):

	# Check if the player is in the player group
	if body.is_in_group("player"):

		player = body
