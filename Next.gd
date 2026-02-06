extends Button


func _on_pressed():
	$"..".visible = false
	$"../..".selected.emit ()
