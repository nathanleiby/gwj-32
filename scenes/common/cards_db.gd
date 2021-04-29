enum { Attack1, Attack2, Defend1, Defend2, QueueBlade, QueueShield, DeckBlade, DeckShield }

enum { Tier1, Tier2, Tier3, Tier4, Tier5 }

enum { AttackType, DefendType }

# Rampage:
# 	{
# 		"title": "Rampage",
# 		"description": "1 + (X/2) damage (X = number of times card has been played)",
# 		"type": AttackType,
# 		"cost": 3,
# 		"rarity": Tier2,
# 		"texture": preload("res://assets/img/attack.svg"),
# 	},

const DATA = {
	Attack1:
	{
		"title": "Attack 1",
		"description": "1 damage",
		"type": AttackType,
		"cost": 1,
		"rarity": Tier1,
		"texture": preload("res://assets/img/attack.svg"),
	},
	Attack2:
	{
		"title": "Attack 2",
		"description": "2 damage",
		"type": AttackType,
		"cost": 2,
		"rarity": Tier2,
		"texture": preload("res://assets/img/attack.svg"),
	},
	QueueBlade:
	{
		"title": "Queue Blade",
		"description": "X damage per Attack card in Queue",
		"type": AttackType,
		"cost": 4,
		"rarity": Tier3,
		"texture": preload("res://assets/img/attack.svg"),
	},
	DeckBlade:
	{
		"title": "Deck Blade",
		"description": "X damage per Attack card in Deck",
		"type": AttackType,
		"cost": 6,
		"rarity": Tier4,
		"texture": preload("res://assets/img/attack.svg"),
	},
	Defend1:
	{
		"title": "Defend 1",
		"type": DefendType,
		"cost": 1,
		"rarity": Tier1,
		"texture": preload("res://assets/img/defend.svg"),
	},
	Defend2:
	{
		"title": "Defend 2",
		"type": DefendType,
		"cost": 2,
		"rarity": Tier2,
		"texture": preload("res://assets/img/defend.svg"),
	},
	QueueShield:
	{
		"title": "Queue Shield",
		"description": "X armor per Defend card in Queue",
		"type": DefendType,
		"cost": 4,
		"rarity": Tier3,
		"texture": preload("res://assets/img/defend.svg"),
	},
	DeckShield:
	{
		"title": "Deck Shield",
		"description": "X armor per Defend card in Deck",
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
