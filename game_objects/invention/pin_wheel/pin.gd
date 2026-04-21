extends MeshInstance3D

@export var rotation_velocity := -5.0
@export var rotation_deceleration := 2.5
@export var spin_speed := -2.50
@export var max_spin_speed := -25.0

func spin():
	rotation_velocity += spin_speed

func _process(delta: float) -> void:
	var target_rotation_velocity = move_toward(rotation_velocity, 0.0, rotation_deceleration * delta)
	rotation_velocity = target_rotation_velocity
	rotation_velocity = clampf(rotation_velocity, max_spin_speed, 0)
	rotation.z += rotation_velocity * delta
