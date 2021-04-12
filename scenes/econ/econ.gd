extends Node2D

const cardsDB = preload("res://scenes/common/cards_db.gd")
const shopCard = preload("res://scenes/econ/ShopCard.tscn")
const cardScene = preload("res://scenes/common/card.tscn")

const X_OFFSET_SHOPCARD = 250
const X_OFFSET_CARD = 60

var forSale = []


func _init():
	print("econ.gd _init()")


func _ready():
	print("econ.gd _ready()")

	# 3 random cards for sale
	forSale.push_back(randomCard())
	forSale.push_back(randomCard())
	forSale.push_back(randomCard())

	setupShopCards()
	setupDeck()
	setupGold()


func randomCard():
	randomize()
	return randi() % len(cardsDB.DATA)


func _on_RefreshButton_pressed():
	setupDeck()
	setupGold()


func _on_ContinueButton_pressed():
	Game.change_scene("res://scenes/gameplay/gameplay.tscn")


func setupShopCards():
	for c in $Shop/ForSaleList.get_children():
		$Shop/ForSaleList.remove_child(c)

	for i in range(len(forSale)):
		var sc = shopCard.instance()
		sc.set_position(Vector2(i * X_OFFSET_SHOPCARD, 0))
		sc.setShopCard(forSale[i])
		$Shop/ForSaleList.add_child(sc)


func setupDeck():
	for c in $Deck/Cards.get_children():
		$Deck/Cards.remove_child(c)

	for i in range(len(Player.deck)):
		var card = Player.deck[i]
		var cs = cardScene.instance()
		cs.set_position(Vector2(i * X_OFFSET_CARD, 30))
		cs.setCard(card)
		$Deck/Cards.add_child(cs)


func setupGold():
	$Deck/Cash.text = str(Player.money) + " gold"
