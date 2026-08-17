extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

var player = null
var speed = 80.0

func _ready():
	player = get_tree().get_first_node_in_group("player")
	animated_sprite.play("Idle")


func _physics_process(delta):
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		return

	var distance = global_position.distance_to(player.global_position)

	# Very close to player = attack
	if distance < 50:
		velocity = Vector2.ZERO
		animated_sprite.play("Attack")

	# Player is nearby = run toward player
	elif distance < 250:
		animated_sprite.play("Run")

		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()

	# Player is far away = idle
	else:
		velocity = Vector2.ZERO
		animated_sprite.play("Idle")
