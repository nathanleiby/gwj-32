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

const zoneToEnemy = {
	'tin': 'Titan of Tin',
	'copper': 'Copper Cyclops',
	'iron': 'Iron Ifrit',
	'mercury': "Magus of Mercury",
	'silver': 'Silver Sailor',
	'lead': 'Leaden Lord',
	'gold': 'Golden Ghost'
}


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
	opponentHp = 10 * Game.level
	opponentAttack = int(floor(1.5 * Game.level))

	# TODO: Add Alchemist levels
	# if Game.level == 8:
	# 	# final level edge case alchemist
	# 	opponentHp = 100
	# 	opponentAttack = 25
	# if Game.level == 9:
	# 	# final level edge case alchemist, phase 2
	# 	opponentHp = 200
	# 	opponentAttack = 40

	deck = Player.deck.duplicate()
	shuffle_deck()

	# Prepare UI
	$PlayerBoard/Deck.text = ""
	$PlayerBoard/Queue.text = ""
	$PlayerBoard/Discard.text = ""
	$PlayerStatus/Title.text = "Player"
	$EnemyStatus/Title.text = "Enemy"  # TODO: Specific enemy
	$Enemy/Title.text = zoneToEnemy[Game.zone]
	$Enemy/Image.texture = load("res://assets/img/enemies/%s.svg" % Game.zone)
	$Enemy/Explain.text = "attacks for %s damage every other turn" % opponentAttack


# `start()` is called when the graphic transition ends.
func start():
	print("\nbattle.gd:start() called")
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


var waitTicksIfOver = 3


func _next_tick():
	## Change scene if we won! (1 tick after the win tick)
	if opponentHp <= 0:
		if waitTicksIfOver >= 0:
			waitTicksIfOver -= 1
			return

		Player.money += Game.level * 2
		Game.level += 1
		if Game.level > 7:
			Game.change_scene("res://scenes/gameover/victory.tscn")
		else:
			Game.change_scene("res://scenes/econ/econ.tscn")
		return

	if Player.currentHP <= 0:
		if waitTicksIfOver >= 0:
			waitTicksIfOver -= 1
			return

		Game.change_scene("res://scenes/gameover/defeat.tscn")
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
	for effect in cardEffects():
		opponentHp -= effect.get(CardEffects.Damage, 0)
		selfArmor += effect.get(CardEffects.Armor, 0)

	# Enemy effects
	if combatTickerValue % 2 == 1:  # enemy attacks every other turn
		selfArmor -= opponentAttack
		if selfArmor < 0:
			Player.currentHP += selfArmor
			selfArmor = 0

	## Update game UI
	$PlayerStatus/HP.text = str(Player.currentHP) + " / " + str(Player.maxHP)
	$PlayerStatus/Armor.text = str(selfArmor)

	$EnemyStatus/HP.text = str(opponentHp)
	$EnemyStatus/Armor.text = str(0)

	$PlayerBoard/Deck.text = "%s cards" % len(deck)
	$PlayerBoard/Discard.text = "%s cards" % len(discard)
	updateQueue()


const X_OFFSET_QUEUECARD = 60


func updateQueue():
	## Show cards in queue
	for c in $PlayerBoard/Queue.get_children():
		$PlayerBoard/Queue.remove_child(c)

	var effects = cardEffects()
	for i in range(queueSize):
		if i < len(queue):
			var card = cardScene.instance()
			card.set_position(Vector2((i + 1) * X_OFFSET_QUEUECARD, 50))
			card.setCard(queue[i])
			$PlayerBoard/Queue.add_child(card)

			# Damage label
			var damageFromCard = effects[i].get(CardEffects.Damage, 0)
			if damageFromCard != 0:
				var label = Label.new()
				label.set_position(Vector2((i + 1) * X_OFFSET_QUEUECARD - 25, 0))
				label.text = str(damageFromCard)
				label.add_color_override("font_color", Color.red)
				$PlayerBoard/Queue.add_child(label)

			# Armor label
			var armorFromCard = effects[i].get(CardEffects.Armor, 0)
			if armorFromCard != 0:
				var armorLabel = Label.new()
				armorLabel.set_position(Vector2((i + 1) * X_OFFSET_QUEUECARD, 0))
				armorLabel.text = str(armorFromCard)
				armorLabel.add_color_override("font_color", Color(.3, .3, .3))
				$PlayerBoard/Queue.add_child(armorLabel)
		else:
			continue
		# TODO: Display empty queue spaces


enum CardEffects {
	Damage,
	Armor,
}


func cardEffects():
	var out = []
	for cur in queue:
		if cur == cardsDB.Attack1:
			out.push_back({CardEffects.Damage: 1})
		if cur == cardsDB.Attack2:
			out.push_back({CardEffects.Damage: 2})
		if cur == cardsDB.QueueBlade:
			var value = 0
			for q in queue:
				if cardsDB.DATA[q]["type"] == cardsDB.AttackType:
					value += 1
			out.push_back({CardEffects.Damage: value})
		if cur == cardsDB.Defend1:
			out.push_back({CardEffects.Armor: 1})
		if cur == cardsDB.Defend2:
			out.push_back({CardEffects.Armor: 2})
		if cur == cardsDB.QueueShield:
			var value = 0
			for q in queue:
				if cardsDB.DATA[q]["type"] == cardsDB.DefendType:
					value += 1
			out.push_back({CardEffects.Armor: value})
	return out
