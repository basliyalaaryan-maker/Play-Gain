extends Node2D

# Connect to the Timer node in Level 2
@onready var level_timer = $LevelTimer

# Connect to the TimerLabel on the HUD
@onready var timer_label = $HUD/TimerLabel

# Starting time for the level
var time_left = 30

# Player's starting health
var player_health = 100


# Runs when Level 2 starts
func _ready():

	# Set the timer to count every 1 second
	level_timer.wait_time = 1.0

	# Make the timer repeat
	level_timer.one_shot = false

	# Start the timer
	level_timer.start()

	# Connect the timer to the countdown function
	level_timer.timeout.connect(_on_level_timer_timeout)

	# Show the starting time
	timer_label.text = "TIME: " + str(time_left)


# Runs every second
func _on_level_timer_timeout():

	# Take 1 second away
	time_left -= 1

	# Update the timer on the screen
	timer_label.text = "TIME: " + str(time_left)

	# If the timer reaches 0, the player loses
	if time_left <= 0:

		# Stop the timer
		level_timer.stop()

		# Make sure the timer shows 0
		timer_label.text = "TIME: 0"

		# Show the Lose Screen
		get_tree().change_scene_to_file(
			"res://Scean/UI/lose_screen.tscn"
		)


# This function removes health when the teacher attacks
func damage_player(amount):

	# Reduce player health
	player_health -= amount

	# Make sure health doesn't go below 0
	if player_health < 0:
		player_health = 0

	print("Player Health: ", player_health)

	# If health reaches 0, the player loses
	if player_health <= 0:

		# Stop the timer
		level_timer.stop()

		# Open Lose Screen
		get_tree().change_scene_to_file(
			"res://Scean/UI/lose_screen.tscn"
		)
