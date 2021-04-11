extends Panel

var rarityToColor = {
	'tier1': Color.white,
	'tier2': Color.green,
	'tier3': Color.blue,
	'tier4': Color.purple,
	'tier5': Color.orange,
}


func _ready():
	# TODO:  Lookup card properties and render it
	$Title.text = "Attack 2"
	$Cost.text = "3 gp"
	var rarity = 'tier2'
	$Icon.modulate = rarityToColor[rarity]
