extends Control

const cardsDB = preload("res://scenes/common/cards_db.gd")

## Parameter
var cardName = cardsDB.Defend1  # can be overwritten before _ready() is called

## Onload
onready var current = cardsDB.DATA[cardName]


func _ready():
	pass


func setCard(c):
	current = cardsDB.DATA[c]
	print("card.setCard = ", current["title"])
	$Icon.modulate = cardsDB.getColor(current["rarity"])
	$Icon.texture = current["texture"]

# func setShopCard(sc):
# 	print(sc)
