extends Node2D

onready var cardScene = preload("res://scenes/common/card.tscn")
onready var cardsDB = preload("res://scenes/common/cards_db.gd")

## Per-Combat state
# PlayerBoard
var queue = []
var queueSize = Player.queueSize
var discard = []

# Time tracking for given combat
var combatTickerValue = -1  # one combat step occurs per tick
var startTime

# Hit points and status
var opponentHp
var opponentAttack
var opponentAttackFrequency = 2

var deck
var selfArmor = 0


# `pre_start()` is called when a scene is totally loaded.
# Use this function to receive params from the scene which
# called `Game.change_scene(params)` and to init your
# new scene.
#
# At this point the game is paused (`get_tree().paused = true`).
func pre_start(params):
	print("\ngameplay.gd:pre_start() called with params = ")
	for key in params:
		var val = params[key]
		printt("", key, val)

	# TODO: Do we need to hide placeholder text?
	$GameStats.text = ""
	$PlayerBoard/Deck.text = ""
	$PlayerBoard/Queue.text = ""
	$PlayerBoard/Discard.text = ""

	deck = Player.deck.duplicate()
	shuffle_deck()

	opponentHp = 10 * Game.level
	opponentAttack = 2 * Game.level


# `start()` is called when the graphic transition ends.
func start():
	print("\ngameplay.gd:start() called")
	var active_scene: Node = Game.get_active_scene()
	print("\nCurrent active scene is: ", active_scene.name, " (", active_scene.filename, ")")

	startTime = OS.get_ticks_msec()


func _process(_delta):
	var elapsed = OS.get_ticks_msec()
	var previousTickerValue = combatTickerValue
	combatTickerValue = int(floor((elapsed - startTime) / 1000))

	if previousTickerValue != combatTickerValue:
		print("Combat ticker=", combatTickerValue)
		_next_tick()


func shuffle_deck():
	print("Shuffling...")
	randomize()
	deck.shuffle()


func _next_tick():
	## Change scene if we won! (1 tick after the win tick)
	if opponentHp <= 0:
		Player.money += Game.level * 2
		Game.level += 1
		Game.change_scene("res://scenes/econ/econ.tscn")
		return

	if Player.currentHP <= 0:
		Game.change_scene("res://scenes/gameover/gameover.tscn")
		return

	########################################
	## Update Deck, Queue, and Discard
	########################################
	if deck.size() == 0:
		deck = discard
		discard = []
		shuffle_deck()

	# draw a card
	var drawnCard = deck.pop_front()

	# make space in queue, if needed
	if len(queue) == queueSize:
		var toDiscard = queue.pop_back()
		discard.push_front(toDiscard)
	# add to queue
	queue.push_front(drawnCard)

	########################################
	## Do effects  of current cards
	########################################

	# Player cards
	for cur in queue:
		if cur == cardsDB.Attack1:
			opponentHp -= 1
		if cur == cardsDB.Attack2:
			opponentHp -= 2
		if cur == cardsDB.QueueBlade:
			var value = 0
			for q in queue:
				if cardsDB.DATA[q]["type"] == cardsDB.AttackType:
					value += 1
			opponentHp -= value
		if cur == cardsDB.Defend1:
			selfArmor += 1
		if cur == cardsDB.Defend2:
			selfArmor += 2
		if cur == cardsDB.QueueShield:
			var value = 0
			for q in queue:
				if cardsDB.DATA[q]["type"] == cardsDB.DefendType:
					value += 1
			selfArmor += value

	# Enemy effects
	if combatTickerValue % 2 == 0:  # enemy attacks every other turn
		selfArmor -= opponentAttack
		if selfArmor < 0:
			Player.currentHP += selfArmor
			selfArmor = 0

	## Update game UI
	$GameStats.text = (
		""
		+ "Level = "
		+ str(Game.level)
		+ "\n"
		+ "\n"
		+ "Self HP = "
		+ str(Player.currentHP)
		+ "\n"
		+ "Self Armor = "
		+ str(selfArmor)
		+ "\n"
		+ "\n"
		+ "Opponent HP = "
		+ str(opponentHp)
		+ "\n"
		+ "Opponent Strength = "
		+ str(opponentAttack)
	)

	$PlayerBoard/Deck.text = str(len(deck))
	$PlayerBoard/Discard.text = str(len(discard))
	updateQueue()


const X_OFFSET_QUEUECARD = 60


func updateQueue():
	## Show cards in queue
	var queueText = ""
	for i in range(0, queueSize):
		if i > 0:
			queueText += " | "

		if i < len(queue):
			var curCard = queue[i]
			print(curCard)
			queueText += cardsDB.DATA[curCard]["title"]
		else:
			queueText += "<empty>"

	$PlayerBoard/Queue.text = queueText
	for c in $PlayerBoard/Queue.get_children():
		$PlayerBoard/Queue.remove_child(c)

	for i in range(queueSize):
		if i < len(queue):
			var card = cardScene.instance()
			card.set_position(Vector2((i + 1) * X_OFFSET_QUEUECARD, 50))
			card.setCard(queue[i])
			$PlayerBoard/Queue.add_child(card)

		# TODO: Display empty queue spaces
