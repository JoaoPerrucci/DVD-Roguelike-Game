extends Node2D

var goal_by_level = [5, 10 ,20, 50, 75, 100, 200, 300, 500, 750,
1000, 1500, 2000, 3000, 5000, 7500,10000, 15000, 20000, 30000,
50000, 75000, 100000, 150000, 225000, 350000, 500000, 750000, 1000000, 1500000, 
2000000, 3000000, 5000000, 10000000, 20000000, 50000000, 150000000, 300000000, 500000000, 700000000,
1000000000]

var clone = load ("res://dvd.tscn")

var cheapskate = 0
var spread_shot = PI
var bank = 0.0

var shot_direction = 0

var goal = '1'


signal selected
signal spawn
signal died
signal reroll
signal after_ready

func _ready():
	$dvd_logo.connect ('died', on_died)
	$".".connect ('selected', start)
	$dvd_logo.connect ('katana', katana)
	
	
func start ():
	spawn.emit ()
	cheapskate = global.money * global.cheapskate
	global.general_multiplier = global.general_multiplier + cheapskate
	#verifies if there's btc in game
	if "res://btc.tscn" in $inventory.inventory:
		global.btc = true
	#shows level
	if len(str(global.goal)) > 9:
		goal = str(global.goal).left(len(str(round(global.goal)))-9) + 'B'
	elif len(str(global.goal)) > 6:
		goal = str(global.goal).left(len(str(round(global.goal)))-6) + 'M'
	else:
		goal = str(global.goal)
	$level.text = "level " + str(global.level) + ": " + $score.score + "/" + goal
	$level.visible = true
	await get_tree().create_timer(1.7).timeout
	$level.visible = false
	
	#spawns dvd
	global.any_alive += 1
	var twin = clone.instantiate ()
	add_child(twin)
	twin.collision_layer = 2 #2
	twin.collision_mask = 1 #1
	twin.connect ('died', on_died)
	twin.connect ('katana', katana)
	twin.connect ('balloon', balloon)
	twin.trueself = true
	twin.name = 'dvd_logo'
	if global.aim:
		twin.i_direction = Vector2 (sin(twin.x), cos(twin.x)).normalized()
	else:
		twin.i_direction = Vector2 (randi_range(-100, 100), randi_range(-100, 100)).normalized()
		
		
		
	if global.evil_twin:
		#faz o evil twin aparecer
		global.any_alive += 1
		#consta que tem mais um dvd em jogo
		var eviltwin = clone.instantiate ()
		add_child(eviltwin)
		eviltwin.collision_mask = 1
		eviltwin.collision_layer = 2
		#nao bate com outros dvds
		eviltwin.i_direction = twin.i_direction * -1
		#direçao oposta
		eviltwin.connect ('died', on_died)
		eviltwin.connect ('katana', katana)
		eviltwin.x = 0
		eviltwin.trueself = false
		eviltwin.name = 'dvd_logo'
		#fala que é copia
	spread_shot = PI
	shot_direction = twin.i_direction.angle_to(Vector2(0,-1))
	for i in global.multishot:
		if spread_shot > 0:
			spread_shot += 0.1
			spread_shot *= -1
		else:
			spread_shot *= -1
		#shotgun effect
		global.any_alive += 1
		#consta que tem mais um dvd em jogo
		var shot = clone.instantiate ()
		add_child(shot)
		shot.collision_mask = 1
		shot.collision_layer = 2
		#nao bate com outros dvds
		shot.connect ('died', on_died)
		shot.connect ('katana', katana)
		shot.x = spread_shot + shot_direction
		shot.i_direction = Vector2(sin(shot.x), cos(shot.x)).normalized()
		#x is degree
		shot.trueself = false
		shot.name = 'dvd_logo'
		shot.hp = global.shot_hp
		shot.speed = 250  
	after_ready.emit()
	
		
func _input(event):
	#atalho de desenvolvedor para testar
	if Input.is_key_pressed(KEY_S):
		selected.emit ()
		global.money += 50
	
	
func on_died ():
	#verifica se a rodada acabou ou nao quando um dvd morre
	if global.any_alive <= 0:
		#cleaning screen and stoping timers
		$balloon_generator.stop()
		for i in $inventory.get_children(): #clear all items but time bomb
			if 'time_bomb' not in i.name:
				i.queue_free()
		died.emit()
		await get_tree().create_timer(0.5).timeout
		cheapskate = global.money * global.cheapskate
		global.general_multiplier = global.general_multiplier - cheapskate
		snapped(global.general_multiplier, 0.1)
		$combo_generator.stop()
		global.mult_of_mult = global.mult_of_mult - global.combo_reset
		global.combo_reset = 0
		global.clapperboard = 0
		if global.btc: #doubles btc price
			global.btc_price *= 2
			
		if global.goal <= global.score: #venceu
			bank = (global.score - global.goal)*global.store_vault
			global.level += 1
			global.score = 0
			reroll.emit()
			$Shop.visible = true
			global.money += 3
			global.score += bank
			bank = 0
			if global.level - 1 <= len(goal_by_level):
				global.goal = goal_by_level[global.level - 2]
			else:
				$level.text = "win"
				$level.visible = true
				$Shop.visible = false
		else: #perdeu
			global.health -= 1
			if global.health <= 0:
				$Game_Over.visible = true
			else:
				reroll.emit()
				$Shop.visible = true
				global.money += 1
		global.score = round(global.score)

func katana(dvd_position, dvd_direction_x, dvd_direction_y, dvd_scale, hp, speed, red, green, color_transition):
	global.any_alive += 1
	
	var cut_dvd = clone.instantiate ()
	add_child(cut_dvd)
	cut_dvd.trueself = false
	cut_dvd.global_position = dvd_position
	cut_dvd.speed = speed
	cut_dvd.linear_velocity = Vector2 (dvd_direction_x+(cut_dvd.speed/4), dvd_direction_y).normalized() * cut_dvd.speed
	cut_dvd.hp = hp
	cut_dvd.space = false
	cut_dvd.collision_mask = 1
	cut_dvd.collision_layer = 2
	cut_dvd.red = red
	cut_dvd.green = green
	cut_dvd.color_transition = color_transition
	if red != 0.0:
		cut_dvd.get_child(0).get_child(1).self_modulate  = Color(red,green,0,1)
		print ('era uhsruob')
	cut_dvd.connect ('died', on_died)
	cut_dvd.connect ('katana', katana)
	cut_dvd.name = 'dvd_logo'
	for i in cut_dvd.get_children():
		i.scale = dvd_scale*0.7
		
	var cut_dvd2 = clone.instantiate ()
	add_child(cut_dvd2)
	cut_dvd2.trueself = false
	cut_dvd2.global_position = dvd_position
	cut_dvd2.speed = speed
	cut_dvd2.linear_velocity = Vector2 (dvd_direction_x-(cut_dvd2.speed/4), dvd_direction_y).normalized() * cut_dvd2.speed
	cut_dvd2.hp = hp
	cut_dvd2.space = false
	cut_dvd2.collision_mask = 1
	cut_dvd2.collision_layer = 2
	cut_dvd2.red = red
	cut_dvd2.green = green
	cut_dvd2.color_transition = color_transition
	if red != 0.0:
		cut_dvd2.get_child(0).get_child(1).self_modulate = Color(red,green,0,1)
	cut_dvd2.connect ('died', on_died)
	cut_dvd2.connect ('katana', katana)
	cut_dvd2.name = 'dvd_logo'
	for i in cut_dvd2.get_children():
		i.scale = dvd_scale*0.7

	
func balloon():
	$balloon_generator.start()
	for i in global.balloon_quantity:
		var spawn_item = load ("res://balloon.tscn")
		var item = spawn_item.instantiate ()
		$inventory.add_child(item)
		item.global_position = Vector2 (randi_range(0, 640), 375)
		item.collision_mask = 0
		item.collision_layer = 16
		item.name = "res://balloon.tscn"
		await get_tree().create_timer(1.2/global.balloon_quantity).timeout
	
