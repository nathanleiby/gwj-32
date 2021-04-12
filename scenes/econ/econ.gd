extends Node2D

const cardsDB = preload("res://scenes/common/cards_db.gd")
const shopCard = preload("res://scenes/econ/ShopCard.tscn")

const X_OFFSET = 250


func _init():
	print("econ.gd _init()")


func _ready():
	print("econ.gd _ready()")
	# TODO: Do an attack and a defned ca
	var sc1 = shopCard.instance()
	sc1.setCard(cardsDB.Attack2)
	var sc2 = shopCard.instance()
	sc2.setCard(cardsDB.Attack2)
	var sc3 = shopCard.instance()
	sc3.setCard(cardsDB.Defend2)
	$Shop/ForSaleList.add_child(sc1)
	$Shop/ForSaleList.add_child(sc2)
	$Shop/ForSaleList.add_child(sc3)

	sc1.set_position(Vector2(0, 0))
	sc2.set_position(Vector2(X_OFFSET, 0))
	sc3.set_position(Vector2(2 * X_OFFSET, 0))
