extends Node2D

# Connect to the Timer node in Level 2
@onready var level_timer = $LevelTimer

# Connect to the TimerLabel on the HUD
@onready var timer_label = $HUD/TimerLabel

# Starting time for the level
var time_left = 30


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

	# Stop when the timer reaches 0
	if time_left <= 0:
		level_timer.stop()
		timer_label.text = "TIME: 0"
