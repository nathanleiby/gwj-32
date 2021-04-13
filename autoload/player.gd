extends Node

# Player
#
# Contains player state that persists across battles

## Health
var maxHP: int = 50
var currentHP: int = 50

## Money
var money: int = 5
var queueSize: int = 3

## Deck
onready var cardsDB = preload("res://scenes/common/cards_db.gd")
onready var deck: Array = [
	cardsDB.Defend1,
	cardsDB.Defend1,
	cardsDB.Attack1,
	cardsDB.Attack1,
	cardsDB.Attack1,
]

## Items
# ..
