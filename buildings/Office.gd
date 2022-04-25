extends Sprite

var NPC = preload("res://entities/NPC/NPC.tscn")

var npc_names = ["ben", "annie", "barbs", "gigi", "jack"]
var npc_name_index = 0
var npc

func spawn_npc(npc_name):
	npc = NPC.instance()
	npc.get_node("Sprite").texture = load("res://assets/npc/" + npc_name + ".png")
	npc.position = $NPCSpawnPoint.position - npc.get_node("Sprite").offset
	npc.num_orders = floor(rand_range(2, 4))
	add_child(npc)
	npc.connect("orders_completed", self, "_on_orders_completed")
	npc.animationPlayer.play("WalkOut")
	yield(npc.animationPlayer, "animation_finished")
	npc.animationPlayer.play("Idle")

func _on_orders_completed():
	npc.animationPlayer.play("WalkIn")
	yield(npc.animationPlayer, "animation_finished")
	npc.queue_free()

	npc_name_index = (npc_name_index + 1) % npc_names.size()
	var npc_name = npc_names[npc_name_index]
	spawn_npc(npc_name)
