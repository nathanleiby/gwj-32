extends Control


func pre_start(params):
	print(params)

	# Indicate metals that are complete
	if Player.aspects['silver']:
		$Panel/Container/Silver/Button.hide()
	if Player.aspects['copper']:
		$Panel/Container/Copper/Button.hide()
	if Player.aspects['tin']:
		$Panel/Container/Tin/Button.hide()
	if Player.aspects['lead']:
		$Panel/Container/Lead/Button.hide()
	if Player.aspects['iron']:
		$Panel/Container/Iron/Button.hide()
	if Player.aspects['gold']:
		$Panel/Container/Gold/Button.hide()
	if Player.aspects['mercury']:
		$Panel/Container/Mercury/Button.hide()

	return


func _on_Button_pressed(zone):
	Game.zone = zone
	Game.change_scene(Game.BATTLE_SCENE)
