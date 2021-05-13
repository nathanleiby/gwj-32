# Game autoload. Use `Game` global variable as a shortcut to access
# features.
# Eg: `Game.change_scene("res://scenes/gameplay/gameplay.tscn)`
# Handles also the main game architecture when playing
# a specific scene.
extends Node

# Progress through game
var level: int = 1
var zones_complete: int = 0  # can get this from aspects earned, as well
var zone = ""

var size: Vector2 setget , get_size

onready var main: Main = get_node_or_null("/root/Main")

const BATTLE_SCENE = "res://scenes/gameplay/battle.tscn"
const ZONE_SELECT_SCENE = "res://scenes/gameplay/ZoneSelect.tscn"
const ZONE_VICTORY_SCENE = "res://scenes/gameplay/ZoneVictory.tscn"
const ECON_SCENE = "res://scenes/econ/econ.tscn"
const VICTORY_SCENE = "res://scenes/gameover/victory.tscn"
const DEFEAT_SCENE = "res://scenes/gameover/defeat.tscn"

const LEVELS_PER_ZONE = 3


func _ready():
	if main == null:
		call_deferred("_force_main_scene_load")


func _force_main_scene_load():
	# Loads scenes/main.tscn and set the currently played
	# scene as ActiveSceneContainer node.
	# Needed when playing a scene which is not
	# scenes/main.tscn (eg:with Play Scene with F6)
	var played_scene = get_tree().current_scene
	if played_scene == null:
		# This should only occur when running unit tests via gut
		return

	var root = get_node("/root")
	main = load("res://scenes/main/main.tscn").instance()
	main.splash_transition_on_start = false
	root.remove_child(played_scene)
	root.add_child(main)
	main.active_scene_container.get_child(0).queue_free()
	main.active_scene_container.add_child(played_scene)
	if played_scene.has_method("pre_start"):
		played_scene.pre_start({})
	if played_scene.has_method("start"):
		played_scene.start()
	played_scene.owner = main


func change_scene(new_scene, params = {}):
	main.change_scene(new_scene, params)


func reparent_node(node: Node2D, new_parent, update_transform = true):
	main.reparent_node(node, new_parent, update_transform)


func get_active_scene() -> Node:
	return main.get_active_scene()


func get_size():
	return main.size


const ZONE_TO_ENEMY = {
	'tin': 'Titan of Tin',
	'copper': 'Copper Cyclops',
	'iron': 'Iron Ifrit',
	'mercury': "Magus of Mercury",
	'silver': 'Silver Sailor',
	'lead': 'Leaden Lord',
	'gold': 'Golden Ghost',
	'alchemist': 'The Alchemist',
}

const IRON_ATTACK_BONUS = 1
const TIN_ARMOR_BONUS = 1
const COPPER_HEAL_BONUS = 5
const MERCURY_DRAW_BONUS = 1
const SILVER_ARMOR_BONUS = 10
const GOLD_GOLD_BONUS = 1

const ZONE_TO_BONUS = {
	'tin': 'Defend cards give +%s armor' % TIN_ARMOR_BONUS,
	'copper': 'Heal %s HP at the end of each battle' % COPPER_HEAL_BONUS,
	'iron': 'Attack cards do +%s damage' % IRON_ATTACK_BONUS,
	'mercury': "Draw +%s card per turn" % MERCURY_DRAW_BONUS,
	'silver': 'Start battle with %s armor' % SILVER_ARMOR_BONUS,
	'lead': 'Start battle with your queue half full (rounded up)',
	'gold': 'Gain +%s gold per enounter' % GOLD_GOLD_BONUS,
	'alchemist': '',
}

# preview of web colors available here: https://www.w3schools.com/colors/colors_names.asp
const ZONE_TO_COLOR = {
	'copper': Color.lawngreen,
	'iron': Color.darkred,
	'mercury': Color.saddlebrown,
	'silver': Color.silver,
	'lead': Color.lightgray,
	'gold': Color.gold,
	'tin': Color.darkorange,
	'alchemist': Color.purple,
}

const BOOST_TICKS = 3
const BOOST_ATTACK_BONUS = 3
