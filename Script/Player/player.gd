extends CharacterBody2D

var speed = 220
var acceleration = 1200
var friction = 1000

var books_collected = 0
 
@onready var books_label = get_node("../HUD/BooksLabel")

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
			
			
func collect_book():
	books_collected += 1

	books_label.text = "Books: " + str(books_collected) + "/3"

	print("Books:", books_collected)

	if books_collected >= 3:
		print("All books collected!")
#When player collect books it print "All books collected"
