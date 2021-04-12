extends Panel

const cardsDB = preload("res://scenes/common/cards_db.gd")

## Parametrize with this
var card

var isSold = false


func _ready():
	pass


func setShopCard(c):
	card = cardsDB.DATA[c]

	# update general card
	$Card.setCard(c)

	# update "shop card"
	$Title.text = card["title"]
	$Cost.text = str(card["cost"]) + " gp"


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
	if Player.money < card["cost"]:
		return false

	# remove card from shop
	isSold = true

	# update player
	Player.money -= card["cost"]
	Player.deck.push_back(card)

	# update ShopCard UI
	$Title.text = "sold"
	$Card.hide()
	$Cost.hide()
	$BuyButton.hide()
