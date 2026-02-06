extends Area2D


var invisible = 1
var t = 1.0
var body_in = 0

func _process(delta):
	t = delta*20
	if body_in == 0:
		$"..".modulate = $"..".modulate.lerp(Color(1,1,1,0.8), t/3)
	else:
		$"..".modulate = $"..".modulate.lerp(Color(1,1,1,0.1), t)


func _on_body_entered(body):
	body_in += 1


func _on_body_exited(body):
	body_in -= 1
