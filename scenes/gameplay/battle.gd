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
	print("\nbattle.gd:pre_start() called with params = ")
	for key in params:
		var val = params[key]
		printt("", key, val)

	# Setup game state
	opponentHp = 10 * Game.LEVELS_PER_ZONE * Game.zones_complete + Game.level
	opponentAttack = int(floor(Game.LEVELS_PER_ZONE * Game.zones_complete + Game.level))

	if Game.zone == 'alchemist':
		# final level edge case alchemist
		if Game.level == 1:
			opponentHp = 250
			opponentAttack = 25
		elif Game.level == 2:
			opponentHp = 400
			opponentAttack = 40
		elif Game.level == 3:
			opponentHp = 600
			opponentAttack = 60

	deck = Player.deck.duplicate()
	shuffle_deck()

	# Prepare UI
	$PlayerBoard/Deck.text = ""
	$PlayerBoard/Queue.text = ""
	$PlayerBoard/Discard.text = ""
	$PlayerStatus/Title.text = "Player"
	$EnemyStatus/Title.text = "Enemy"  # TODO: Specific enemy
	$Enemy/Title.text = Game.ZONE_TO_ENEMY[Game.zone]
	$Enemy/Image.texture = load("res://assets/img/enemies/%s.svg" % Game.zone)
	$Enemy/Explain.text = "attacks for %s damage every other turn" % opponentAttack
	$Enemy/ZoneLevel.text = "Zone %s, Level %s" % [Game.zones_complete + 1, Game.level]


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

		# winings
		Player.money += (Game.zones_complete * Game.LEVELS_PER_ZONE + Game.level)
		Game.level += 1

		# game over? or econ scene
		if Game.level > Game.LEVELS_PER_ZONE:
			if Game.zone == 'alchemist':
				Game.change_scene(Game.VICTORY_SCENE)
			else:
				Player.aspects[Game.zone] = true
				Game.level = 1
				Game.zones_complete += 1
				Game.change_scene(Game.ZONE_SELECT_SCENE)
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
