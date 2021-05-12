extends Node2D

const cardsDB = preload("res://scenes/common/cards_db.gd")
const shopCard = preload("res://scenes/econ/ShopCard.tscn")
const cardScene = preload("res://scenes/common/card.tscn")
const deckCardScene = preload("res://scenes/econ/DeckCard.tscn")

const X_OFFSET_SHOPCARD = 250
const X_OFFSET_DECKCARD = 120
const Y_OFFSET_DECKCARD = 120
const DECKCARDS_PER_ROW = 7

# TODO: Move these to a central place, where I can tweak game design params
const QUEUE_SIZE_COST = 10
const DECK_SIZE_COST = 5
const HEALING_COST = 5
const HEALING_HP_AMOUNT = 10

var forSale = []
var nextScene = Game.BATTLE_SCENE


func pre_start(params):
	if params.has("from"):
		nextScene = params["from"]
	else:
		nextScene = Game.BATTLE_SCENE


func _ready():
	print("econ.gd _ready()")

	# 3 random cards for sale
	for _i in range(3):
		var card = randomCardOfTier(randomTierWeighted())
		forSale.push_back(card)

	setupShopCards()
	setupDeck()
	setupPlayerHUD()


func randomCard():
	randomize()
	return randi() % len(cardsDB.DATA)


func randomTierWeighted():
	randomize()
	var r = randf()
	if r < 0.5:  # 50% chance
		return cardsDB.Tier1
	elif r < .75:  # 25% chance
		return cardsDB.Tier2
	elif r < .90:  # 15% chance
		return cardsDB.Tier3
	elif r < .97:  # 7% chance
		return cardsDB.Tier4
	else:  # 3% chance
		return cardsDB.Tier5


func randomCardOfTier(tier):
	randomize()

	var cardsOfTier = []
	for k in cardsDB.DATA.keys():
		if cardsDB.DATA[k]["rarity"] == tier:
			cardsOfTier.push_back(k)

	if len(cardsOfTier) == 0:
		# fallback in case we have no cards of a given tier during dev
		return randomCardOfTier(tier - 1)

	return cardsOfTier[randi() % len(cardsOfTier)]


func _on_RefreshButton_pressed():
	setupDeck()
	setupPlayerHUD()


func _on_BuyQueueSizeButton_pressed():
	# can't buy it
	if Player.money < QUEUE_SIZE_COST:
		return false

	# update player
	Player.money -= QUEUE_SIZE_COST
	Player.queueSize += 1
	setupPlayerHUD()


func _on_BuyDeckSizeButton_pressed():
	# can't buy it
	if Player.money < DECK_SIZE_COST:
		return false

	# update player
	Player.money -= DECK_SIZE_COST
	Player.maxDeckSize += 1
	setupPlayerHUD()


func _on_BuyHealingButton_pressed():
	# can't buy it
	if Player.money < HEALING_COST || Player.currentHP == Player.maxHP:
		return false

	# update player
	Player.money -= HEALING_COST
	Player.currentHP += HEALING_HP_AMOUNT
	Player.currentHP = int(clamp(Player.currentHP, 0, Player.maxHP))
	setupPlayerHUD()


func _on_ContinueButton_pressed():
	Game.change_scene(nextScene)


func setupShopCards():
	for c in $Shop/ForSaleList.get_children():
		$Shop/ForSaleList.remove_child(c)

	for i in range(len(forSale)):
		var sc = shopCard.instance()
		sc.set_position(Vector2(i * X_OFFSET_SHOPCARD, 0))
		sc.setShopCard(forSale[i])
		$Shop/ForSaleList.add_child(sc)

	$Shop/BuyDeckSizeButton.text = "+1 Deck Size (" + str(DECK_SIZE_COST) + " gp)"
	$Shop/BuyQueueSizeButton.text = "+1 Queue Size (" + str(QUEUE_SIZE_COST) + " gp)"
	$Shop/BuyHealingButton.text = "Heal %s HP (%s gp)" % [HEALING_HP_AMOUNT, HEALING_COST]


func setupDeck():
	for c in $Deck/Cards.get_children():
		$Deck/Cards.remove_child(c)

	for i in range(len(Player.deck)):
		var card = Player.deck[i]
		var cs = deckCardScene.instance()

		var col = i % DECKCARDS_PER_ROW
		#warning-ignore:integer_division
		var row = i / DECKCARDS_PER_ROW
		cs.set_position(Vector2(col * X_OFFSET_DECKCARD, -10 + row * Y_OFFSET_DECKCARD))
		cs.setCard(card)
		$Deck/Cards.add_child(cs)


func setupPlayerHUD():
	$HUD/Cash.text = str(Player.money) + " gold"
	$HUD/QueueSize.text = str(Player.queueSize) + " qsize"
	$HUD/DeckSize.text = str(Player.maxDeckSize) + " dsize"
	$HUD/HP.text = "(" + str(Player.currentHP) + " / " + str(Player.maxHP) + ")"
