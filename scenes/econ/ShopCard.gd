extends Panel

const cardsDB = preload("res://scenes/common/cards_db.gd")

## Parametrize with this
var cardName
var cardData

var isSold = false


func _ready():
	pass


func setShopCard(c):
	cardName = c
	cardData = cardsDB.DATA[cardName]

	# update general card
	$Card.setCard(cardName)

	# update "shop card"
	$Title.text = cardData["title"]
	$Cost.text = str(cardData["cost"]) + " gp"


func _on_BuyButton_pressed():
	print("buy button pressed")
	if isSold:
		print("how tho, the card is already sold")
		return

	var success = buy_card()
	if ! success:
		return


func buy_card():
	# can't buy it
	if Player.money < cardData["cost"]:
		return false

	# remove card from shop
	isSold = true

	# update player
	Player.money -= cardData["cost"]
	Player.deck.push_back(cardName)

	# update ShopCard UI
	$Title.text = "sold"
	$Card.hide()
	$Cost.hide()
	$BuyButton.hide()
