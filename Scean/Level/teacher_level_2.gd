extends CharacterBody2D

# ================================================
# TEACHER SETTINGS
# ================================================

@onready var animated_sprite = $AnimatedSprite2D

# Player reference
var player = null

# Teacher movement speed
var speed = 80.0

# Books needed to complete Level 2
var total_books = 8

# Prevents win screen triggering more than once
var game_complete = false


# ================================================
# ATTACK SETTINGS
# ================================================

# Damage teacher does each attack
var attack_damage = 10

# Time between attacks
var attack_cooldown = 1.0

# Controls whether teacher can attack
var can_attack = true


# ================================================
# READY
# ================================================

func _ready():

	# Find player
	player = get_tree().get_first_node_in_group("player")

	# Start teacher idle
	animated_sprite.play("Idle")


# ================================================
# TEACHER MOVEMENT / ATTACK
# ================================================

func _physics_process(_delta):

	# Try to find player if not found
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		return

	# Get player's books
	var books = player.books_collected

	# Distance between teacher and player
	var distance = global_position.distance_to(
		player.global_position
	)


	# ================================================
	# PLAYER HAS ALL 8 BOOKS
	# ================================================

	if books >= total_books:

		# Player reached teacher
		if distance < 50:

			velocity = Vector2.ZERO

			animated_sprite.play("Idle")

			# Win only once
			if not game_complete:

				game_complete = true

				print("LEVEL 2 COMPLETE!")

				# Stop Level 2 timer
				var level_timer = get_node_or_null("../LevelTimer")

				if level_timer:
					level_timer.stop()

				# Go to Win Screen
				get_tree().change_scene_to_file(
					"res://Scean/win_screen.tscn"
				)

		else:

			# Teacher follows player
			var direction = global_position.direction_to(
				player.global_position
			)

			velocity = direction * speed

			animated_sprite.play("Run")

			move_and_slide()

		return


	# ================================================
	# PLAYER DOES NOT HAVE ALL 8 BOOKS
	# ================================================

	# Teacher attacks when close
	if distance < 50:

		velocity = Vector2.ZERO

		animated_sprite.play("Attack")

		# Damage player
		if can_attack:
			attack_player()


	# Teacher follows player
	elif distance < 200:

		var direction = global_position.direction_to(
			player.global_position
		)

		velocity = direction * speed

		animated_sprite.play("Run")

		move_and_slide()


	# Teacher stays idle when player is far away
	else:

		velocity = Vector2.ZERO

		animated_sprite.play("Idle")


# ================================================
# ATTACK PLAYER
# ================================================

func attack_player():

	# Prevent instant repeated attacks
	can_attack = false

	# Check player has take_damage function
	if player != null and player.has_method("take_damage"):

		# Take 10 health
		player.take_damage(attack_damage)

		print("Teacher attacked player!")

	# Wait 1 second before next attack
	await get_tree().create_timer(
		attack_cooldown
	).timeout

	can_attack = true


# ================================================
# PLAYER ENTERS INTERACTION AREA
# ================================================

func _on_interaction_area_body_entered(body):

	if body.is_in_group("player"):

		player = body
