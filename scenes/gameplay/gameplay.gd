extends Node2D

# hold the value of what tick we're on for the given combat
var combatTickerValue = -1
var cards = ["attack", "defend"]

var deck = [0, 0, 1, 0, 1, 1]
var queue = []
var queueSize = 2
var discard = []

var startTime


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

	$Queue/Dialog.text = ""


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

	# if Input.ision_just_pressed("ui_accept"):


# TODO: Hit points of opponent
var opponentHp = 10
var selfHp = 99
var selfArmor = 0


## Dialog
func _next_tick():
	## Update game state

	########################################
	## Update Deck, Queue, and Discard
	########################################
	if deck.size() == 0:
		print("Shuffling...")
		deck = discard
		discard = []
		randomize()
		deck.shuffle()

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
	for qCard in queue:
		var cur = cards[qCard]
		if cur == "attack":
			opponentHp -= 1
		elif cur == "defend":
			selfArmor += 1

	# Enemy effects
	if combatTickerValue % 2 == 0:
		selfHp -= 2

	## Update game UI
	$GameStats.text = (
		"Deck Size = "
		+ str(len(deck))
		+ "\n"
		+ "Discard Size = "
		+ str(len(discard))
		+ "\n"
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
	for qCard in queue:
		queueText += (cards[qCard] + "\n")

	$Queue/Dialog.text = queueText
