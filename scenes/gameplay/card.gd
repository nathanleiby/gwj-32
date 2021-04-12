extends Node2D

# Load the Db
onready var CardsDB = preload("res://scenes/common/cards_db.gd")

# load the current card
var curCard = CardsDB.Attack1
onready var CardInfo = CardsDB.DATA[curCard]


func _ready():
	print(CardsDB.Attack1)
