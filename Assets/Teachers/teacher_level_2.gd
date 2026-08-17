extends CharacterBody2D

# How fast the teacher moves when chasing the player
var speed = 120

# Reference to the player
var player

# Reference to the teacher's animations
@onready var animated_sprite = $AnimatedSprite2D


func _ready():
	# Find the player in the Level 2 scene
	player = get_tree().get_first_node_in_group("player")


func _physics_process(delta):

	# If there is no player, stop
	if player == null:
		animated_sprite.play("idle")
		return

	# Calculate the distance between teacher and player
	var distance = global_position.distance_to(player.global_position)

	# If the teacher is close enough, chase the player
	if distance < 500:

		var direction = global_position.direction_to(player.global_position)

		velocity = direction * speed

		move_and_slide()

		# Play the running animation
		animated_sprite.play("run")

	else:
		# Teacher is not chasing
		velocity = Vector2.ZERO

		animated_sprite.play("idle")
