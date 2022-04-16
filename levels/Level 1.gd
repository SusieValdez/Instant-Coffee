extends Level

var BUTLER = preload("res://entities/BUTLER/BUTLER.tscn")
onready var BUTLER_spawn_position = $Office/BUTLERSpawnPoint.global_position
onready var BUTLER_list = $BUTLERs

func _on_BUTLERSpawnTimer_timeout():
	var shop = get_node("Shops/HotCoffeeShop") # TODO: Replace with random shop
	var shopPosition = shop.position
	var itemPosition = shop.get_node("ItemSpawnLocations/1").position # TODO: Replace with random item
	var new_BUTLER = BUTLER.instance()
	new_BUTLER.position = BUTLER_spawn_position
	new_BUTLER.commands = [
		["MOVE", getTelporterPosition(1)],
		["TELEPORT", getTelporterPosition(2)],
		["MOVE", getTelporterPosition(3)],
		["TELEPORT", getTelporterPosition(4)],
		["MOVE", shopPosition + itemPosition],
		["INTERACT"],
		["MOVE", getTelporterPosition(4)],
		["TELEPORT", getTelporterPosition(3)],
		["MOVE", getTelporterPosition(2)],
		["TELEPORT", getTelporterPosition(1)],
		["MOVE", BUTLER_spawn_position],
		["DESPAWN"],
	]
	BUTLER_list.add_child(new_BUTLER)
	$BUTLERSpawnTimer.wait_time = rand_range(10, 20)
	$BUTLERSpawnTimer.start()

func getTelporterPosition(id: int):
	return get_node("TeleportPedestals/" + str(id)).position
