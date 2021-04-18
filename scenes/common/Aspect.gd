extends Panel

export (String) var aspectName = ""


func setAspect(name: String):
	if aspectName == "":
		return

	aspectName = name

	# change background color of panel
	# https://godotengine.org/qa/4195/edit-styleboxflat-background-colour-assigned-panel-gdscript
	var new_style = StyleBoxFlat.new()
	new_style.set_bg_color(Game.ZONE_TO_COLOR[name])
	self.set('custom_styles/panel', new_style)

	$CenterContainer/VBoxContainer/CenterContainer/TextureRect.texture = load(
		"res://assets/img/alchemy-symbols/%s.svg" % name
	)
	$CenterContainer/VBoxContainer/Button.text = name.capitalize()


func _ready():
	setAspect(aspectName)


func hideButton():
	$CenterContainer/VBoxContainer/Button.hide()


func _on_Button_pressed():
	Game.zone = aspectName
	Game.change_scene(Game.BATTLE_SCENE)
