enum { Attack1, Attack2, Defend1, Defend2, QueueBlade, QueueShield }

enum { Tier1, Tier2, Tier3, Tier4, Tier5 }

enum { AttackType, DefendType }

const DATA = {
	Attack1:
	{
		"title": "Attack 1",
		"description": "1 damage",
		"type": AttackType,
		"cost": 1,
		"damage": 1,
		"rarity": Tier1,
		"texture": preload("res://assets/img/attack.svg"),
	},
	Attack2:
	{
		"title": "Attack 2",
		"description": "2 damage",
		"type": AttackType,
		"cost": 2,
		"damage": 2,
		"rarity": Tier2,
		"texture": preload("res://assets/img/attack.svg"),
	},
	QueueBlade:
	{
		"title": "Queue Blade",
		"description": "X damage per attack card in queue",
		"type": AttackType,
		"cost": 2,
		"damage": 2,
		"rarity": Tier3,
		"texture": preload("res://assets/img/attack.svg"),
	},
	Defend1:
	{
		"title": "Defend 1",
		"type": DefendType,
		"cost": 1,
		"armor": 2,
		"rarity": Tier1,
		"texture": preload("res://assets/img/defend.svg"),
	},
	Defend2:
	{
		"title": "Defend 2",
		"type": DefendType,
		"cost": 2,
		"armor": 2,
		"rarity": Tier2,
		"texture": preload("res://assets/img/defend.svg"),
	},
	QueueShield:
	{
		"title": "Queue Shield",
		"description": "X armor per Defend card in queue",
		"type": DefendType,
		"cost": 4,
		"rarity": Tier3,
		"texture": preload("res://assets/img/defend.svg"),
	}
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
