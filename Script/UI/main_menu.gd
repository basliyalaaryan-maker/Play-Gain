extends Control

# Play game
func _on_start_button_pressed():
	print("start Clicked")
	get_tree().change_scene_to_file("res://MainGame.tscn")


# Open options (or placeholder for now)
func _on_options_button_pressed():
	print("Options clicked")
	# get_tree().change_scene_to_file("res://OptionsMenu.tscn")


# Quit game
func _on_quit_button_pressed():
	print("Quit Clicked")
	get_tree().quit()
