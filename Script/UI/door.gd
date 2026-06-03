extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var collision = $StaticBody2D/CollisionShape2D
@onready var door_sound = $AudioStreamPlayer2D

var player_near = false
var is_open = false

func _process(_delta):
	if player_near and Input.is_action_just_pressed("interact"):
		toggle_door()

# IF PRESS E TO OPEN DOOR AND CLOSE
func toggle_door():
	is_open = !is_open

	door_sound.play()

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
