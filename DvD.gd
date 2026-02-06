extends RigidBody2D

var speed = global.speed
var hp = global.hp
var x:float = PI
#x is degree
var trueself = false
var i_direction =  Vector2 (randi_range(-100, 100), randi_range(-100, 100)).normalized()
var space = true
var chance = 0

var label = load ("res://label.tscn")
var glass = load ("res://assets/DVD_glass.png")
var fade_out = load ("res://fade_out.tscn")
var points_added = 0
var position_on_impact = 0

var red = 0.0
var green = 1.0
var color_transition = 2.0

signal died
signal katana
signal balloon

func _ready():
	$".".name = 'dvd_logo'
	$"..".connect('after_ready', after_ready)
	#mira on e off deopendendo do aim
	$CollisionShape2D/aim_line.visible = false
	if global.glass:
		$CollisionShape2D/Sprite2D.texture = glass
		$CollisionShape2D/Sprite2D.self_modulate = Color(1,1,1,1)
		
		
#define mira e tamanho do dvd
func after_ready ():
	color_transition = 2.0/hp
	if global.aim and trueself:
		$CollisionShape2D/aim_line.visible = true
		#mira pra cima
		$CollisionShape2D/aim_line.points [1] = Vector2 (sin(x), cos(x)).normalized()*50
	else:
		$CollisionShape2D/aim_line.visible = false
	for i in $".".get_children():
		i.scale *= global.dvd_initial_size

func _input(event):
	if Input.is_key_pressed(KEY_SPACE) and space:
		#atira o dvd
		linear_velocity = i_direction* speed
		$CollisionShape2D/aim_line.visible = false
		balloon.emit()
		space = false

func _physics_process(delta):
	if global.aim and space:
	#mexe a mira
		if Input.is_key_pressed(KEY_D):
			x -= 0.25*PI * get_process_delta_time()
			i_direction = Vector2 (sin(x), cos(x)).normalized()
			$CollisionShape2D/aim_line.points [1] = (Vector2 (sin(x), cos(x)).normalized())*50
		if Input.is_key_pressed(KEY_A):
			x += 0.25*PI * get_process_delta_time()
			i_direction = Vector2 (sin(x), cos(x)).normalized()
			$CollisionShape2D/aim_line.points [1] = (Vector2 (sin(x), cos(x)).normalized())*50
			
	var collision = move_and_collide(linear_velocity*delta)
	if $CollisionShape2D.global_position.y > (360 - 13*$CollisionShape2D.scale.y) or $CollisionShape2D.global_position.y < (0 + 13*$CollisionShape2D.scale.y):
		points_added += global.clapperboard*global.general_multiplier*global.mult_of_mult #clapperboard
		linear_velocity.y *= -1
		points_added += global.wall * global.wall_mult * global.general_multiplier * global.mult_of_mult
		global.score += points_added
		var points = label.instantiate ()
		$"..".add_child(points)
		points.global_position = Vector2 ($".".global_position.x+15-float(str(points_added).length())*4.65, $".".global_position.y - 5)
		points.text = str(round(points_added))
		points_added = 0
		#ponto por bater na parede
		$CollisionShape2D/Sprite2D.self_modulate = Color(red,green,0,1)
		red += color_transition
		if red > 1:
			green -= color_transition
		if hp <= 0:
			#ao bater, se a vida ja estiver no zero ele morre
			queue_free()
			global.any_alive -= 1
			died.emit ()
		hp -= 1
		#perde vida
	if $CollisionShape2D.global_position.x > (640 - 26*$CollisionShape2D.scale.x) or $CollisionShape2D.global_position.x <  (0 + 26*$CollisionShape2D.scale.x):
		points_added += global.clapperboard*global.general_multiplier*global.mult_of_mult #clapperboard
		linear_velocity.x *= -1
				#linear_velocity = linear_velocity.reflect(collision.get_normal())
		#linear_velocity = -linear_velocity.reflect(collision.get_normal())
		points_added += global.wall * global.wall_mult * global.general_multiplier * global.mult_of_mult
		global.score += points_added
		var points = label.instantiate ()
		$"..".add_child(points)
		points.global_position = Vector2 ($".".global_position.x+15-float(str(points_added).length())*4.65, $".".global_position.y - 5)
		points.text = str(round(points_added))
		points_added = 0
		#ponto por bater na parede
		$CollisionShape2D/Sprite2D.self_modulate = Color(red,green,0,1)
		red += color_transition
		if red > 1:
			green -= color_transition
		if hp <= 0:
			#ao bater, se a vida ja estiver no zero ele morre
			queue_free()
			global.any_alive -= 1
			died.emit ()
		hp -= 1
		#perde vida
	if collision:
		if  'mirror' in collision.get_collider().name:
			linear_velocity = linear_velocity.bounce(collision.get_normal())
			var mirror = str(round(global.score))
			var mirrored = mirror.split()
			mirrored.reverse()
			mirror = str (mirrored)
			global.score += int (mirror)
			points_added = int (mirror)
			var points = label.instantiate ()
			$"..".add_child(points)
			points.global_position = Vector2 ($".".global_position.x+15-float(str(points_added).length())*4.65, $".".global_position.y - 5)
			points.text = str(round(points_added))
			points_added = 0
			chance = randi_range(1,100)
			if chance >= global.mirror_chance:
				$"../inventory".inventory.erase ("res://mirror.tscn")
				collision.get_collider().get_child(0).get_child(0).play('mirror')
				await collision.get_collider().get_child(0).get_child(0).animation_finished
			collision.get_collider().queue_free()
			global.mult_of_mult += global.combo
			global.combo_reset += global.combo
			$"../combo_generator".stop()
			$"../combo_generator".start()

func _on_area_2d_dvd_body_entered(body):
	if 'Wall' in body.name:
		return
	points_added += global.clapperboard*global.general_multiplier*global.mult_of_mult #clapperboard
	global.score += global.clapperboard*global.general_multiplier*global.mult_of_mult
	#combo
	global.mult_of_mult += global.combo
	global.combo_reset += global.combo
	position_on_impact = body.global_position
	
	$"../combo_generator".stop()
	$"../combo_generator".start()
	if  'banana' in body.name:
		points_added +=  global.banana * global.general_multiplier*global.mult_of_mult
		global.score += points_added
		linear_velocity = Vector2 (randi_range(-100, 100), randi_range(-100, 100)).normalized()*speed

	elif  'popcorn' in body.name:
		points_added += global.popcorn * global.general_multiplier*global.mult_of_mult
		global.score += points_added
		#body.queue_free()
		
	elif  'btc' in body.name:
		global.btc = false
		points_added += global.btc_price * global.general_multiplier*global.mult_of_mult
		global.score += points_added
	
	elif  'katana' in body.name:
		#$".".collision_mask = 0
		#$Area2D_dvd.collision_mask = 0
		body.get_child(0).set_deferred('disabled', 1)
		#$".".visible = false
		var dvd_position = $".".global_position
		var dvd_direction_x = $".".linear_velocity.x
		var dvd_direction_y = $".".linear_velocity.y
		var dvd_scale = $".".get_child(0).scale
		katana.emit(dvd_position, dvd_direction_x, dvd_direction_y, dvd_scale, hp, speed, red, green, color_transition)
		body.get_child(0).get_child(0).play('katana')
		$".".queue_free()
		
	elif  'balloon' in body.name:
		points_added += global.balloon * global.general_multiplier*global.mult_of_mult
		global.score += points_added

	elif  'coin' in body.name:
			global.money += global.coin_money
			global.general_multiplier += global.coin_money * global.cheapskate
			points_added += global.coin_points * global.general_multiplier*global.mult_of_mult
			global.score += points_added

	elif 'arrow' in body.name:
		points_added += global.arrow * global.general_multiplier*global.mult_of_mult
		global.score += points_added
		linear_velocity = Vector2 (body.get_child(0).global_position.x - body.get_child(1).global_position.x, body.get_child(0).global_position.y - body.get_child(1).global_position.y).normalized()*speed

	elif 'dragon_egg' in body.name:
		points_added += global.dragon_egg * global.general_multiplier*global.mult_of_mult
		global.score += points_added
		body.global_position = Vector2 (randi_range(8, 632), randi_range(8, 352))
		for i in body.get_children():
			i.position = Vector2 (0,0)

	elif 'mushroom' in body.name:
		points_added += global.mushroom * global.general_multiplier*global.mult_of_mult
		global.score += points_added
		for i in $".".get_children():
			i.scale *= 1.3

	if points_added >0:
		var points = label.instantiate ()
		$"..".add_child(points)
		points.global_position = Vector2 (position_on_impact.x - float(str(points_added).length())*4.65, position_on_impact.y - 12)
		points.text = str(round(points_added))
	points_added = 0
	if ('dragon_egg' not in body.name) and ('clapperboard' not in body.name):
		var fade = fade_out.instantiate ()
		$"..".add_child(fade)
		if 'katana' in body.name:
			fade.wait_time = 1
		fade.body = body
		fade.start()
		body.collision_layer = 0

