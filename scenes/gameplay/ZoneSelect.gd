extends Control


func pre_start(params):
	print(params)
	# TODO: unlock alchemist battle given some condition?
	return


func _on_Button_pressed(zone):
	Game.zone = zone
	Game.change_scene(Game.BATTLE_SCENE)
