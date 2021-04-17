extends Panel


func setAspect(name: String):
	# change background color of panel
	# https://godotengine.org/qa/4195/edit-styleboxflat-background-colour-assigned-panel-gdscript
	var new_style = StyleBoxFlat.new()
	new_style.set_bg_color(Game.ZONE_TO_COLOR[name])
	self.set('custom_styles/panel', new_style)

	$CenterContainer/VBoxContainer/CenterContainer/TextureRect.texture = load(
		"res://assets/img/alchemy-symbols/%s.svg" % name
	)
	$CenterContainer/VBoxContainer/Button.text = name.capitalize()


func hideButton():
	$CenterContainer/VBoxContainer/Button.hide()
