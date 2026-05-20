extends CharacterBody2D

var speed = 220

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):

	var direction = Input.get_vector(
		"ui_left",
		"ui_right",
		"ui_up",
		"ui_down"
	)

	velocity = direction * speed

	move_and_slide()

	# Idle animation
	if direction == Vector2.ZERO:

		animated_sprite.play("Idle")

	# Left / Right
	elif abs(direction.x) > abs(direction.y):

		if direction.x > 0:
			animated_sprite.play("walk_right")
		else:
			animated_sprite.play("walk_left")

	# Up / Down
	else:

		if direction.y > 0:
			animated_sprite.play("walk_down")
		else:
			animated_sprite.play("walk_up")
			print("running")
