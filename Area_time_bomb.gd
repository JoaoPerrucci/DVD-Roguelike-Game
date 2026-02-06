extends Area2D

var hits = 10
var level = 3
var pos = Vector2 (0, 0)
var explosion = 0

func _ready():
	get_tree().get_root().get_node("World").connect('died', died)
	$"../Label".text = str(hits)
	get_tree().get_root().get_node("World").connect('spawn', spawn)
	explosion = $".".get_child(0).get_child(0)
	
func _on_body_entered(body):
	if 'dvd_logo' in body.name:
		#combo
		global.general_multiplier += global.combo
		global.combo_reset += global.combo
		get_tree().get_root().get_node("World/combo_generator").stop()
		get_tree().get_root().get_node("World/combo_generator").start()
		#clapperboard
		global.score += global.clapperboard *global.general_multiplier*global.mult_of_mult
		
		hits -= 1
		$"../Label".text = str(hits)
		if hits <= 0:
			global.general_multiplier += 5
			$"..".queue_free()
			
func died():
	level -= 1
	if level <= 0:
		global.health -= 10
		explosion.play('explosion')
		await get_tree().create_timer(0.4).timeout
		$"..".queue_free()
	$"..".visible = false

func spawn ():
	$"../Collision_time_bomb_spawn".set_deferred('disabled', 0)
	pos = Vector2 (randi_range(0, 640), randi_range(0, 360))
	$"..".global_position = pos
	while pos <= get_tree().get_root().get_node("World/dvd_area").global_position + Vector2 (20, 20) and pos >= get_tree().get_root().get_node("World/dvd_area").global_position - Vector2 (20, 20):
		pos = Vector2 (randi_range(0, 640), randi_range(0, 360))
	await get_tree().create_timer(1.7).timeout
	$"../Collision_time_bomb_spawn".set_deferred('disabled', 1)
	$"..".visible = true
