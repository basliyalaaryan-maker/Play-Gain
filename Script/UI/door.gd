extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var collision = $StaticBody2D/CollisionShape2D

var player_near = false
var is_open = false

func _process(delta):
	if player_near and Input.is_action_just_pressed("interact"):
		toggle_door()

func toggle_door():
	is_open = !is_open

	if is_open:
		collision.disabled = true
		sprite.visible = false
	else:
		collision.disabled = false
		sprite.visible = true

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		player_near = true

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		player_near = false
