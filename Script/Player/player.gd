extends CharacterBody2D

var speed = 220
var acceleration = 1200
var friction = 1000

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):

	# player input
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	# movement
	var target_velocity = direction * speed

	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(target_velocity, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	move_and_slide()

	# animations

	if direction == Vector2.ZERO:
		animated_sprite.play("Idle")

	elif abs(direction.x) > abs(direction.y):

		if direction.x > 0:
			animated_sprite.play("walk_right")
		else:
			animated_sprite.play("walk_left")

	else:

		if direction.y < 0:
			animated_sprite.play("walk_up")
		else:
			animated_sprite.play("Idle")
