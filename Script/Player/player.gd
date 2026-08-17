extends CharacterBody2D

# Player movement settings
var speed = 220
var acceleration = 1200
var friction = 1000

# Stores how many books the player has collected
var books_collected = 0

# The total number of books required in the current level
# Level 1 = 3 books
# Level 2 = 8 books
@export var total_books = 3

# Gets the book counter from the HUD
@onready var books_label = get_node("../HUD/BooksLabel")

# Gets the player's animated sprite
@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta):

	# Get the direction the player is moving
	var direction = Input.get_vector(
		"ui_left",
		"ui_right",
		"ui_up",
		"ui_down"
	)

	# Calculate the player's target movement speed
	var target_velocity = direction * speed

	# Move the player towards the target speed
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(
			target_velocity,
			acceleration * delta
		)
	else:
		# Slow the player down when no movement key is pressed
		velocity = velocity.move_toward(
			Vector2.ZERO,
			friction * delta
		)

	# Move the CharacterBody2D
	move_and_slide()


	# -------------------------
	# PLAYER ANIMATIONS
	# -------------------------

	# Play idle animation when the player is not moving
	if direction == Vector2.ZERO:
		animated_sprite.play("Idle")

	# Check whether the player is moving more horizontally
	elif abs(direction.x) > abs(direction.y):

		# Play the correct walking animation
		if direction.x > 0:
			animated_sprite.play("walk_right")
		else:
			animated_sprite.play("walk_left")

	# Player is moving vertically
	else:

		# Play walking-up animation
		if direction.y < 0:
			animated_sprite.play("walk_up")
		else:
			# Use idle animation when walking down
			animated_sprite.play("Idle")


func collect_book():

	# Increase the number of collected books by 1
	books_collected += 1

	# Update the HUD using the total number of books
	# required for the current level
	books_label.text = "Books: " + str(books_collected) + "/" + str(total_books)

	# Print the number of books collected in the debugger
	print("Books:", books_collected)

	# Check whether the player has collected all required books
	if books_collected >= total_books:
		print("All books collected!")
