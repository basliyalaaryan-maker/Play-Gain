extends Node2D

@onready var level_timer = $LevelTimer
@onready var timer_label = $HUD/TimerLabel
@onready var health_bar = $HUD/HealthBar

# Starting time
var time_left = 30

# Starting player health
var player_health = 100

# Stops the lose screen after winning
var game_won = false


func _ready():

	# Set up the timer
	level_timer.wait_time = 1.0
	level_timer.one_shot = false

	level_timer.timeout.connect(_on_level_timer_timeout)

	level_timer.start()

	# Show starting time
	timer_label.text = "TIME: " + str(time_left)

	# Show starting health
	health_bar.value = player_health

	# Make sure all books are active at the start of the level
	for book in get_tree().get_nodes_in_group("books"):
		book.visible = true


func _on_level_timer_timeout():

	# Don't lose if the player has already won
	if game_won:
		level_timer.stop()
		return

	# Take 1 second away
	time_left -= 1

	# Update timer
	timer_label.text = "TIME: " + str(time_left)

	# Time has run out
	if time_left <= 0:

		level_timer.stop()
		timer_label.text = "TIME: 0"

		# Check if player has all 8 books
		var player = get_tree().get_first_node_in_group("player")

		if player != null and player.books_collected >= 8:
			return

		# Player loses
		get_tree().change_scene_to_file(
			"res://Scean/UI/lose_screen.tscn"
		)


# ----------------------------------------
# DAMAGE PLAYER
# ----------------------------------------

func damage_player(amount):

	# Reduce health
	player_health -= amount

	# Don't allow health below 0
	if player_health < 0:
		player_health = 0

	# Update health bar
	health_bar.value = player_health

	# Print health in Output for testing
	print("Player Health: ", player_health)

	# If health reaches 0, lose
	if player_health <= 0:

		level_timer.stop()

		get_tree().change_scene_to_file(
			"res://Scean/UI/lose_screen.tscn"
		)
