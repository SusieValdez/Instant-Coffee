extends Panel


func _process(_delta):
	var player = get_node("../../Player")
	var inventory = player.inventory
	for i in player.MAX_INVENTORY_SIZE:
		var textureRect = get_node("ItemSlot" + str(i + 1)).get_node("TextureRect")
		textureRect.texture = null
		if i < inventory.size():
			var item_name = inventory[i]
			textureRect.texture = load("res://assets/items/" + item_name + ".png")
