extends Node2D


func _ready():
	var aspectName = Game.zone

	$Panel/AspectName.bbcode_text = "[center]%s[/center]" % aspectName.to_upper()
	var bonus = Game.ZONE_TO_BONUS[aspectName]
	$Panel/EnemyDefeated.text = "The %s has been defeated!" % Game.ZONE_TO_ENEMY[aspectName]
	$Panel/AspectExplain.text = (
		"You acquired the aspect of %s.\n\nBonus: %s"
		% [aspectName.capitalize(), bonus]
	)
	$Panel/Aspect.setAspect(aspectName)
	$Panel/Aspect.hideButton()


func _on_ContinueButton_pressed():
	Game.change_scene(Game.ZONE_SELECT_SCENE)
