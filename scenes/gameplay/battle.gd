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
var opponentMaxHP
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
	print("\nbattle.gd:pre_start() called with params = ")
	for key in params:
		var val = params[key]
		printt("", key, val)

	# Setup game state
	var difficulty = Game.LEVELS_PER_ZONE * Game.zones_complete + Game.level
	if Game.zone == 'alchemist':
		# final level edge case alchemist
		if Game.level == 1:
			difficulty = 25
		elif Game.level == 2:
			difficulty = 35
		elif Game.level == 3:
			difficulty = 50

	opponentMaxHP = 10 * difficulty
	opponentAttack = ceil(difficulty * .75)

	opponentHp = opponentMaxHP

	if Player.aspects['silver']:
		selfArmor += Game.SILVER_ARMOR_BONUS

	deck = Player.deck.duplicate()
	shuffle_deck()

	# Prepare UI
	$Enemy/Status/Title.text = "Enemy"
	$Player/Status/Title.text = "Player"
	$Enemy/Title.text = Game.ZONE_TO_ENEMY[Game.zone]
	$Enemy/Image.texture = load("res://assets/img/enemies/%s.svg" % Game.zone)
	$Enemy/Explain.text = "attacks for %s damage every other turn" % opponentAttack
	$Enemy/ZoneLevel.text = "Zone %s, Level %s" % [Game.zones_complete + 1, Game.level]

	$Player/CardBar.setQueueSize(Player.queueSize)
	$Enemy/CardBar.setQueueSize(1)  # TODO


# `start()` is called when the graphic transition ends.
func start():
	print("\nbattle.gd:start() called")
	var active_scene: Node = Game.get_active_scene()
	print("\nCurrent active scene is: ", active_scene.name, " (", active_scene.filename, ")")

	startTime = OS.get_ticks_msec()

	if Player.aspects['lead']:
		var cardsToDraw = int(floor(float(Player.queueSize) / 2))  # e.g. player has queue size of 5, we expect lead to cause 2cards + 1 for draw
		for _i in range(cardsToDraw):
			drawCard()


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


var waitTicksIfOver = 3


func _next_tick():
	## Change scene if we won! (1 tick after the win tick)
	if opponentHp <= 0:
		if waitTicksIfOver >= 0:
			waitTicksIfOver -= 1
			return

		# winings
		Player.money += (Game.zones_complete * Game.LEVELS_PER_ZONE + Game.level)
		if Player.aspects['gold']:
			Player.money += 1
		Game.level += 1

		# game over? or econ scene
		if Game.level > Game.LEVELS_PER_ZONE:
			# aspect of copper
			if Player.aspects['copper']:
				Player.currentHP += Game.COPPER_HEAL_BONUS
				Player.currentHP = int(clamp(Player.currentHP, 0, Player.maxHP))

			if Game.zone == 'alchemist':
				Game.change_scene(Game.VICTORY_SCENE)
			else:
				Player.aspects[Game.zone] = true
				Game.level = 1
				Game.zones_complete += 1
				Music.switchMusic(Music.Songs.Regular)
				Game.change_scene(Game.ZONE_VICTORY_SCENE)
		else:
			Game.change_scene(Game.ECON_SCENE)

		return

	if Player.currentHP <= 0:
		if waitTicksIfOver >= 0:
			waitTicksIfOver -= 1
			return

		Game.change_scene(Game.DEFEAT_SCENE)
		return

	########################################
	## Update Deck, Queue, and Discard
	########################################
	drawCard()
	if Player.aspects['mercury']:
		drawCard()

	########################################
	## Do effects  of current cards
	########################################

	# Player cards
	for effect in cardEffects():
		opponentHp -= effect.get(CardEffects.Damage, 0)
		selfArmor += effect.get(CardEffects.Armor, 0)

	# Enemy effects
	if combatTickerValue % 2 == 1:  # enemy attacks every other turn
		selfArmor -= opponentAttack
		if selfArmor < 0:
			Player.currentHP += selfArmor
			selfArmor = 0

	refreshUI()


func refreshUI():
	## Update game UI
	$Player/Status/HP.text = str(Player.currentHP) + " / " + str(Player.maxHP)
	$Player/Status/Armor.text = str(selfArmor)

	$Enemy/Status/HP.text = str(opponentHp)
	$Enemy/Status/Armor.text = str(0)

	$Player/CardBar.setDeckCount(len(deck))
	$Player/CardBar.setDiscardCount(len(discard))
	updateQueue()


const X_OFFSET_QUEUECARD = 60


func drawCard():
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


func updateQueue():
	var effects = cardEffects()
	for i in range(queueSize):
		if i < len(queue):
			var damageFromCard = effects[i].get(CardEffects.Damage, 0)
			var armorFromCard = effects[i].get(CardEffects.Armor, 0)
			$Player/CardBar.setCard(i, queue[i], damageFromCard, armorFromCard)
		else:
			continue
		# TODO: Display empty (locked) queue spaces


enum CardEffects {
	Damage,
	Armor,
}


func cardEffects():
	var out = []
	var attackBonus = 0
	if Player.aspects['iron']:
		attackBonus = Game.IRON_ATTACK_BONUS

	var defendBonus = 0
	if Player.aspects['tin']:
		defendBonus = Game.TIN_ARMOR_BONUS

	for cur in queue:
		if cur == cardsDB.Attack1:
			out.push_back({CardEffects.Damage: 1 + attackBonus})
		if cur == cardsDB.Attack2:
			out.push_back({CardEffects.Damage: 2 + attackBonus})
		if cur == cardsDB.QueueBlade:
			var value = 0
			for q in queue:
				if cardsDB.DATA[q]["type"] == cardsDB.AttackType:
					value += 1
			out.push_back({CardEffects.Damage: value + attackBonus})
		if cur == cardsDB.DeckBlade:
			var value = 0
			for d in Player.deck:  # all cards in deck
				if cardsDB.DATA[d]["type"] == cardsDB.AttackType:
					value += 1
			out.push_back({CardEffects.Damage: value + attackBonus})
		if cur == cardsDB.Defend1:
			out.push_back({CardEffects.Armor: 1 + defendBonus})
		if cur == cardsDB.Defend2:
			out.push_back({CardEffects.Armor: 2 + defendBonus})
		if cur == cardsDB.QueueShield:
			var value = 0
			for q in queue:
				if cardsDB.DATA[q]["type"] == cardsDB.DefendType:
					value += 1
			out.push_back({CardEffects.Armor: value + defendBonus})
		if cur == cardsDB.DeckShield:
			var value = 0
			for d in Player.deck:  # all cards in deck
				if cardsDB.DATA[d]["type"] == cardsDB.DefendType:
					value += 1
			out.push_back({CardEffects.Armor: value + defendBonus})
	return out
