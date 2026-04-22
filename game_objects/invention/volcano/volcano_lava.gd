class_name VolcanoLava
extends RigidBody3D

@export var despawn_time := 3.0

func _physics_process(delta: float) -> void:
	if despawn_time > 0.0:
		despawn_time -= delta
		return
	queue_free()
