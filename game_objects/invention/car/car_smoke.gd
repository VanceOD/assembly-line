extends RigidBody3D

var despawn_timer := 0.65

func _physics_process(delta: float) -> void:
	if despawn_timer > 0.0:
		despawn_timer -= delta
		return
	queue_free()
