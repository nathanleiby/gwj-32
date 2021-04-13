extends Panel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const TRASH_CARD_COST = 5

const cardsDB = preload("res://scenes/common/cards_db.gd")
var cardName


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


func setCard(c):
	cardName = c
	$Card.setCard(c)
	var cardData = cardsDB.DATA[c]
	$Title.text = cardData["title"]


func trashCard():
	if Player.money < TRASH_CARD_COST:
		# can't afford
		return

	var foundIdx = Player.deck.find(cardName)
	if foundIdx < 0:
		# no matching card found
		return

	Player.money -= TRASH_CARD_COST
	Player.deck.remove(foundIdx)

	self.hide()  # TODO: we'll want to delete n signal later


func _on_TrashButton_pressed():
	trashCard()
