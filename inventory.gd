extends Node2D

var inventory = []
var pos = Vector2 (0, 0)
var len_inventory = 0


func _ready():
	$"..".connect('spawn', spawn)

func spawn ():
	$".".visible = false
	for node in inventory:
		var spawn_item = load (node)
		var item = spawn_item.instantiate ()
		add_child(item)
		item.name = node
		item.collision_layer = 4 #3
		item.collision_mask = 13 #1,3,4
		if 'mirror' in item.name:
			item.collision_layer = 5
		pos = Vector2 (randi_range(8, 632), randi_range(8, 352))
		while sqrt((pos.x - $"../dvd_area/Collision_dvd_area".global_position.x)**2 + (pos.y - $"../dvd_area/Collision_dvd_area".global_position.y)**2) <= global.radius:
			pos = Vector2 (randi_range(8, 632), randi_range(8, 352))
		item.global_position = pos
		#item.freeze
	len_inventory = len(inventory)
	for i in len_inventory:
		inventory.erase ("res://time_bomb.tscn")
	await get_tree().create_timer(1.7).timeout
	$".".visible = true


