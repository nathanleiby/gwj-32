extends Control


func _on_MainMenuButton_pressed():
	Game.change_scene("res://scenes/menu/menu.tscn", {'show_progress_bar': false})
