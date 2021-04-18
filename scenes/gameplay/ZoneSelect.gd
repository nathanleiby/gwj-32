extends Control


func pre_start(params):
	print(params)

	# Indicate metals that are complete
	if Player.aspects['silver']:
		$Panel/Container/Silver.hideButton()
	if Player.aspects['copper']:
		$Panel/Container/Copper.hideButton()
	if Player.aspects['tin']:
		$Panel/Container/Tin.hideButton()
	if Player.aspects['lead']:
		$Panel/Container/Lead.hideButton()
	if Player.aspects['iron']:
		$Panel/Container/Iron.hideButton()
	if Player.aspects['gold']:
		$Panel/Container/Gold.hideButton()
	if Player.aspects['mercury']:
		$Panel/Container/Mercury.hideButton()


func _on_Button_pressed(zone):
	Game.zone = zone
	# Music.switchMusic(Music.Songs.Battle)
	Game.change_scene(Game.BATTLE_SCENE)


func _on_ShopButton_pressed():
	Game.change_scene(Game.ECON_SCENE, {"from": Game.ZONE_SELECT_SCENE})
