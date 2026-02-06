extends Button


func _on_pressed():
	$"../..".visible = false
	$"../../../level".visible = true
	$"../../../level".text = 'Level 1 of 42'
	await get_tree().create_timer(2.5).timeout
	$"../../..".selected.emit ()
	$"../../../score".visible = true
	$"../../../score".visible = true
	for i in $"../../..".get_children():
		if 'dvd_logo' in i.name:
			i.queue_free()
			global.any_alive -= 1
