extends Node2D

const cardsDB = preload("res://scenes/common/cards_db.gd")

## Parameter
var cardName = cardsDB.Defend1  # can be overwritten before _ready() is called

## Onload
onready var current = cardsDB.DATA[cardName]


func _ready():
	$ExplainText.hide()


func setCard(c):
	current = cardsDB.DATA[c]
	print("card.setCard = ", current["title"])
	$Icon.modulate = cardsDB.getColor(current["rarity"])
	$Icon.texture = current["texture"]
	var explain = current.get("description", "missing description")
	$ExplainText.bbcode_text = "[center]%s[/center]" % explain


func _on_Area2D_mouse_entered():
	$ExplainText.show()
	print("entered!")


func _on_Area2D_mouse_exited():
	$ExplainText.hide()
	print("exited!")
