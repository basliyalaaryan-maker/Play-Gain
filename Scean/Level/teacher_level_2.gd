extends CharacterBody2D

# Teacher's animated sprite
@onready var animated_sprite = $AnimatedSprite2D

# Player reference
var player = null

# Teacher movement speed
var speed = 80.0

# Number of books needed to finish Level 2
var total_books = 8

# Stops the win screen from triggering repeatedly
var game_complete = false


func _ready():

	# Find the player
	player = get_tree().get_first_node_in_group("player")

	# Start with Idle animation
	animated_sprite.play("Idle")


func _physics_process(_delta):

	# If player can't be found, try again
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		return

	# Get books collected
	var books = player.books_collected

	# Calculate distance to player
	var distance = global_position.distance_to(player.global_position)


	# ================================================
	# PLAYER HAS COLLECTED ALL 8 BOOKS
	# ================================================

	if books >= total_books:

		# Player reached teacher
		if distance < 50:

			# Stop teacher
			velocity = Vector2.ZERO

			# Idle animation
			animated_sprite.play("Idle")

			# Trigger win only once
			if not game_complete:

				game_complete = true

				# Stop Level 2 timer
				var level_timer = get_node_or_null("../LevelTimer")

				if level_timer:
					level_timer.stop()

				# Go to Win Screen
				get_tree().change_scene_to_file(
					"res://Scean/win_screen.tscn"
				)

		else:

			# Follow player
			var direction = global_position.direction_to(
				player.global_position
			)

			velocity = direction * speed

			# Run animation
			animated_sprite.play("Run")

			move_and_slide()

		return


	# ================================================
	# PLAYER HAS NOT COLLECTED ALL 8 BOOKS
	# ================================================

	# Teacher attacks when very close
	if distance < 50:

		velocity = Vector2.ZERO

		# Attack animation
		animated_sprite.play("Attack")


	# Teacher follows when nearby
	elif distance < 200:

		var direction = global_position.direction_to(
			player.global_position
		)

		velocity = direction * speed

		# Run animation
		animated_sprite.play("Run")

		move_and_slide()


	# Teacher stays still when far away
	else:

		velocity = Vector2.ZERO

		# Idle animation
		animated_sprite.play("Idle")


# ================================================
# PLAYER ENTERS INTERACTION AREA
# ================================================

func _on_interaction_area_body_entered(body):

	if body.is_in_group("player"):

		player = body
