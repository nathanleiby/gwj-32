extends Node2D

onready var cardsDB = preload("res://scenes/common/cards_db.gd")

## Per-Combat state
# PlayerBoard
var queue = []
var queueSize = 3
var discard = []

# Time tracking for given combat
var combatTickerValue = -1  # one combat step occurs per tick
var startTime

# Hit points and status
var opponentHp = 10
var deck
var selfHp
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
	selfHp = Player.currentHP


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
		Game.change_scene("res://scenes/econ/econ.tscn")

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
		if cur == cardsDB.Defend1:
			selfArmor += 1
		if cur == cardsDB.Defend2:
			selfArmor += 2

	# Enemy effects
	if combatTickerValue % 2 == 0:
		var enemyAttack = 5
		selfArmor -= enemyAttack
		if selfArmor < 5:
			selfHp += selfArmor
			selfArmor = 0

	## Update game UI
	$GameStats.text = (
		""
		+ "Self HP = "
		+ str(selfHp)
		+ "\n"
		+ "Self Armor = "
		+ str(selfArmor)
		+ "\n"
		+ "Opponent HP = "
		+ str(opponentHp)
	)

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

	$PlayerBoard/Deck.text = str(len(deck))
	$PlayerBoard/Queue.text = queueText
	$PlayerBoard/Discard.text = str(len(discard))
