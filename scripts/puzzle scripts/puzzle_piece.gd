extends Area2D
signal piece_collected

func _on_body_entered(body: Node2D) -> void:
	if body.name == 'player':
		emit_signal("piece_collected")
		queue_free()
	
