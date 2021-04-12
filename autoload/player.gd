extends Node

# Player
#
# Contains player state that persists across battles

## Health
var maxHP: int = 99
var currentHP: int = 81

## Deck
onready var cardsDB = preload("res://scenes/common/cards_db.gd")
onready var deck: Array = [
	cardsDB.Defend1,
	cardsDB.Defend1,
	cardsDB.Defend1,
	cardsDB.Attack1,
	cardsDB.Attack1,
	cardsDB.Attack1,
]

## Items
# ..
