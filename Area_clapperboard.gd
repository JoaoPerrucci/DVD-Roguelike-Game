extends Area2D



func _on_body_entered(body):
	if 'dvd_logo' in body.name:
		$"..".collision_layer = 0
		$"..".collision_mask = 0
		$".".collision_mask = 0
		global.clapperboard += global.wall * global.wall_mult
		$"../Collision_clapperboard/Sprite_clapperboard".play("clapperboard")
		await $"../Collision_clapperboard/Sprite_clapperboard".animation_finished
		$"..".visible = false
		await get_tree().create_timer(3).timeout
		global.clapperboard -= global.wall * global.wall_mult
		$"..".queue_free()
