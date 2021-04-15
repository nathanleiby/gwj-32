extends Node

# Imports
const cardsDB = preload("res://scenes/common/cards_db.gd")

##
const startingDeck: Array = [
	cardsDB.Defend1,
	cardsDB.Defend1,
	cardsDB.Attack1,
	cardsDB.Attack1,
	cardsDB.Attack1,
]

# include all cardssure no crashes
var debugDeck = cardsDB.DATA.keys()

# Player
#
# Contains player state that persists across battles

## Health
var maxHP: int = 50
var currentHP: int = maxHP

## Money
var money: int = 5

## Deck
var maxDeckSize: int = 10
onready var deck: Array = startingDeck
# onready var deck: Array = debugDeck  # testing123..

## Queue
var queueSize: int = 3

## Items
# ..

## Aspects
var aspects = {
	'tin': false,
	'copper': false,
	'iron': false,
	'mercury': false,
	'silver': false,
	'lead': false,
	'gold': false,
}
