











## This game

- Create the "econ" scene
    * choosing card(s) to add to your deck (varible cost)
    * trashing cards (increasing cost per trashed card, possible decrease per round), healing
    * growing your queue (increasing cost per slot)
- Create the overall game flow
  - 7 levels of combat + econ
  - after (as) 7th level, a big boss battle
    * idea: boss should mess with your queue somehow .. e.g. "disable" a card, lock a card in a position, etc

## General

- make a package of "godot utils",
  - simple data structure like a queue, pqueue, etc
  - 2d grid for rectangular, tile based games
  - hexagonal grid
  - etc
- try writing some unit tests (e.g. for core game, similar to Letterjam tests)
  - https://github.com/bitwes/Gut
- make F2 rename work in gdscript in vscode





extends Node2D

onready var cardsDB = preload("res://scenes/common/cards_db.gd")

# Called when the node enters the scene tree for the first time.
var available_cards = [
	cardsDB.Attack2,
	cardsDB.Defend2,
]


func _init():
	print("\necon.gd:start() called")
	var active_scene: Node = Game.get_active_scene()
	print("\nCurrent active scene is: ", active_scene.name, " (", active_scene.filename, ")")

	print("ECON READY")
	var shopCard = load("res://scenes/econ/ShopCard.gd")
	var sc1 = shopCard.instance()
	var sc2 = shopCard.instance()
	$Shop/ForSaleList.add_child(sc1)
	$Shop/ForSaleList.add_child(sc2)
