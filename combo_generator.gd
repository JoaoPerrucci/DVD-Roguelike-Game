extends Timer


func _on_timeout():
	global.mult_of_mult = global.mult_of_mult - global.combo_reset
	global.combo_reset = 0
