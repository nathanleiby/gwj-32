enum {
	Attack1,
	Attack2,
	DeckBlade,
	DeckShield,
	Defend1,
	Defend2,
	HeatingUp,
	QueueBlade,
	QueueShield,
}

enum { Tier1, Tier2, Tier3, Tier4, Tier5 }

enum { AttackType, DefendType }

const DATA = {
	Attack1:
	{
		"title": "Attack 1",
		"description": "Deal 1 damage",
		"type": AttackType,
		"cost": 1,
		"rarity": Tier1,
		"texture": preload("res://assets/img/attack.svg"),
	},
	Attack2:
	{
		"title": "Attack 2",
		"description": "Deal 2 damage",
		"type": AttackType,
		"cost": 2,
		"rarity": Tier2,
		"texture": preload("res://assets/img/attack.svg"),
	},
	QueueBlade:
	{
		"title": "Queue Blade",
		"description": "Deal 1 damage per Attack card in Queue",
		"type": AttackType,
		"cost": 4,
		"rarity": Tier3,
		"texture": preload("res://assets/img/attack.svg"),
	},
	DeckBlade:
	{
		"title": "Deck Blade",
		"description": "Deal 1 damage per Attack card in Deck",
		"type": AttackType,
		"cost": 6,
		"rarity": Tier4,
		"texture": preload("res://assets/img/attack.svg"),
	},
	HeatingUp:
	{
		"title": "Heating Up",
		"description": "Deal 1 damage per time this card has been drawn",
		"type": AttackType,
		"cost": 2,
		"rarity": Tier1,
		"texture": preload("res://assets/img/cards/fire-bowl.svg"),
	},
	Defend1:
	{
		"title": "Defend 1",
		"description": "Add 1 armor",
		"type": DefendType,
		"cost": 1,
		"rarity": Tier1,
		"texture": preload("res://assets/img/defend.svg"),
	},
	Defend2:
	{
		"title": "Defend 2",
		"description": "Add 2 armor",
		"type": DefendType,
		"cost": 2,
		"rarity": Tier2,
		"texture": preload("res://assets/img/defend.svg"),
	},
	QueueShield:
	{
		"title": "Queue Shield",
		"description": "Add 1 armor per Defend card in Queue",
		"type": DefendType,
		"cost": 4,
		"rarity": Tier3,
		"texture": preload("res://assets/img/defend.svg"),
	},
	DeckShield:
	{
		"title": "Deck Shield",
		"description": "Add 1 armor per Defend card in Deck",
		"type": DefendType,
		"cost": 6,
		"rarity": Tier4,
		"texture": preload("res://assets/img/defend.svg"),
	},
}

const rarityToColor = {
	Tier1: Color.white,
	Tier2: Color.green,
	Tier3: Color.blue,
	Tier4: Color.purple,
	Tier5: Color.orange,
}

static func getColor(tier):
	return rarityToColor[tier]
