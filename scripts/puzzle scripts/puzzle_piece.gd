extends Area2D
signal piece_collected
@onready var particles: GPUParticles2D = $GPUParticles2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == 'player':
		particles.restart()
		emit_signal("piece_collected")
		sprite.visible = false
		collision.set_deferred("disabled", true)
		await get_tree().create_timer(particles.lifetime).timeout
		queue_free()
