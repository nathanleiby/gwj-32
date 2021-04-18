extends Panel

const cardsDB = preload("res://scenes/common/cards_db.gd")
const padlockTexture = preload("res://assets/img/icons/padlock.svg")


func setCard(cardIdx, cardName, damageFromCard, armorFromCard):
	var queueChildren = $MarginContainer/HBoxContainer/Queue.get_children()

	var current = cardsDB.DATA[cardName]
	var img = queueChildren[cardIdx].get_node('Image')
	img.texture = current["texture"]
	img.modulate = cardsDB.getColor(current["rarity"])

	var damageNode = queueChildren[cardIdx].get_node('Damage')
	if damageFromCard == 0:
		damageNode.text = ""
	else:
		damageNode.text = str(damageFromCard)

	var armorNode = queueChildren[cardIdx].get_node('Armor')
	if armorFromCard == 0:
		armorNode.text = ""
	else:
		armorNode.text = str(armorFromCard)


func setQueueSize(n):
	var queueChildren = $MarginContainer/HBoxContainer/Queue.get_children()
	var cardIdx = 0
	for child in queueChildren:
		var img = queueChildren[cardIdx].get_node('Image')
		var damageNode = queueChildren[cardIdx].get_node('Damage')
		var armorNode = queueChildren[cardIdx].get_node('Armor')
		if cardIdx < n:
			# var img = queueChildren[cardIdx].get_node('Image')
			# img.texture = current["texture"]
			# img.modulate = cardsDB.getColor(current["rarity"])
			# child.
			pass
		else:
			img.texture = padlockTexture
			img.modulate = Color(.3, .3, .3, .3)
			damageNode.text = ""
			armorNode.text = ""

		cardIdx += 1


func setDeckCount(n):
	$MarginContainer/HBoxContainer/DrawPile/Label.text = "%s cards" % n


func setDiscardCount(n):
	$MarginContainer/HBoxContainer/DiscardPile/Label.text = "%s cards" % n
