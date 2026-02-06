extends Timer

var body
var t = 0

func _process(delta):
	if body!= null:
		t += delta*2
		body.modulate = body.modulate.lerp(Color(1,1,1,0), t)
		


func _on_timeout():
	if body != null:
		body.queue_free()
	$".".queue_free()
