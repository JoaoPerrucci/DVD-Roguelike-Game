extends Button


func _on_pressed():
	get_tree().reload_current_scene()
	#hud
	global.score = 0
	global.money = 0
	global.level = 1
	global.goal = 1
	global.health = 5   #player health
	global.general_multiplier = 1
	global.mult_of_mult = 1


	#internal code
	global.any_alive = 1
	global.hp = 5   #bounces
	global.radius = 50

	#items:
	global.wall = 1
	global.wall_mult = 1

	global.evil_twin = false

	global.aim = false

	global.banana = 10

	global.popcorn = 5

	global.balloon = 5
	global.balloon_quantity = 0

	global.btc = false
	global.btc_price = 1

	global.cheapskate = 0

	global.coin_money = 1
	global.coin_points = 1

	global.multishot = 0
	global.shot_hp = 0

	global.combo_reset = 0
	global.combo = 0.0

	global.clapperboard = 0

	global.store_vault = 0.0

	global.arrow = 1

	global.dvd_initial_size = 1.0

	global.speed = 150

	global.dragon_egg = 1

	global.mushroom = 1

	global.mirror_chance = 10

	global.glass = false

