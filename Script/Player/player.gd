extends CharacterBody2D

# ================================================
# PLAYER MOVEMENT SETTINGS
# ================================================

var speed = 220
var acceleration = 1200
var friction = 1000


# ================================================
# BOOK SYSTEM
# ================================================

# Number of books collected
var books_collected = 0

# Level 1 = 3 books
# Level 2 = 8 books
@export var total_books = 3


# ================================================
# HEALTH SYSTEM
# ================================================

# Maximum health
var max_health = 100

# Current health
var health = 100


# ================================================
# NODE REFERENCES
# ================================================

# Books label
@onready var books_label = get_node_or_null("../HUD/BooksLabel")

# Health bar
# get_node_or_null prevents an error if a level has no HealthBar
@onready var health_bar = get_node_or_null("../HUD/HealthBar")

# Player animation
@onready var animated_sprite = $AnimatedSprite2D


# ================================================
# READY
# ================================================

func _ready():

	# Set up HealthBar if this level has one
	if health_bar != null:
		health_bar.max_value = max_health
		health_bar.value = health

	# Set up BooksLabel if this level has one
	if books_label != null:
		books_label.text = (
			"Books: "
			+ str(books_collected)
			+ "/"
			+ str(total_books)
		)


# ================================================
# PLAYER MOVEMENT
# ================================================

func _physics_process(delta):

	# Get movement direction
	var direction = Input.get_vector(
		"ui_left",
		"ui_right",
		"ui_up",
		"ui_down"
	)

	# Calculate target velocity
	var target_velocity = direction * speed

	# Accelerate while moving
	if direction != Vector2.ZERO:

		velocity = velocity.move_toward(
			target_velocity,
			acceleration * delta
		)

	else:

		# Slow down when player stops moving
		velocity = velocity.move_toward(
			Vector2.ZERO,
			friction * delta
		)

	# Move player
	move_and_slide()


	# ================================================
	# PLAYER ANIMATIONS
	# ================================================

	# Player standing still
	if direction == Vector2.ZERO:

		animated_sprite.play("Idle")


	# Player moving horizontally
	elif abs(direction.x) > abs(direction.y):

		if direction.x > 0:

			animated_sprite.play("walk_right")

		else:

			animated_sprite.play("walk_left")


	# Player moving vertically
	else:

		if direction.y < 0:

			animated_sprite.play("walk_up")

		else:

			animated_sprite.play("Idle")


# ================================================
# BOOK COLLECTION
# ================================================

func collect_book():

	# Add one book
	books_collected += 1

	# Update BooksLabel
	if books_label != null:

		books_label.text = (
			"Books: "
			+ str(books_collected)
			+ "/"
			+ str(total_books)
		)

	print("Books: ", books_collected)

	# Check if all required books are collected
	if books_collected >= total_books:

		print("All books collected!")


# ================================================
# PLAYER TAKES DAMAGE
# ================================================

func take_damage(amount):

	# Reduce player health
	health -= amount

	# Don't allow health below 0
	health = max(health, 0)

	# Update HealthBar
	if health_bar != null:
		health_bar.value = health

	# Show health in debugger
	print("Player Health: ", health)

	# ================================================
	# PLAYER DIED
	# ================================================

	if health <= 0:

		print("Player defeated!")

		# Go to Lose Screen
		get_tree().change_scene_to_file(
			"res://Scean/lose_screen.tscn"
		)
