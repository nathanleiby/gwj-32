extends Panel

const cardsDB = preload("res://scenes/common/cards_db.gd")

var card = cardsDB.DATA[cardsDB.Attack1]

var isSold = false


func setCard(cardName):
	card = cardsDB.DATA[cardName]


func _ready():
	print("Shop card rdy")
	$Title.text = card["title"]
	$Cost.text = str(card["cost"]) + " gp"
	$Icon.modulate = cardsDB.getColor(card["rarity"])
	$Icon.texture = card["texture"]

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
	$Cost.hide()
	$Icon.hide()
	$BuyButton.hide()
