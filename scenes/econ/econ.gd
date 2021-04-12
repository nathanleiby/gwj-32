extends Node2D

const cardsDB = preload("res://scenes/common/cards_db.gd")
const shopCard = preload("res://scenes/econ/ShopCard.tscn")
const cardScene = preload("res://scenes/common/card.tscn")

const X_OFFSET_SHOPCARD = 250
const X_OFFSET_CARD = 60


func _init():
	print("econ.gd _init()")


func _ready():
	print("econ.gd _ready()")
	# TODO: Do an attack and a defned ca
	var sc1 = shopCard.instance()
	sc1.setShopCard(cardsDB.Attack2)
	var sc2 = shopCard.instance()
	sc2.setShopCard(cardsDB.Attack2)
	var sc3 = shopCard.instance()
	sc3.setShopCard(cardsDB.Defend2)
	$Shop/ForSaleList.add_child(sc1)
	$Shop/ForSaleList.add_child(sc2)
	$Shop/ForSaleList.add_child(sc3)
	sc1.set_position(Vector2(0 * X_OFFSET_SHOPCARD, 0))
	sc2.set_position(Vector2(1 * X_OFFSET_SHOPCARD, 0))
	sc3.set_position(Vector2(2 * X_OFFSET_SHOPCARD, 0))

	for i in range(len(Player.deck)):
		var card = Player.deck[i]
		var cs = cardScene.instance()
		cs.set_position(Vector2(i * X_OFFSET_CARD, 30))
		cs.setCard(card)
		$Deck/Cards.add_child(cs)

# func _process():
# 	$Deck/Cards
