extends RigidBody3D

@export var bounce_strength := 2.5

func bounce():
	var downward_impuulse := Vector3.DOWN * bounce_strength
	var bounce_impulse := downward_impuulse + random_vector()
	apply_central_impulse(bounce_impulse)
	var torque_impulse = random_vector(0.05)
	apply_torque_impulse(torque_impulse)

func random_vector(variance := 0.50) -> Vector3:
	var result: Vector3
	var x := randf_range(-variance, variance)
	var y := randf_range(-variance, variance)
	var z := randf_range(-variance, variance)
	result = Vector3(x, y, z)
	return result

func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	var mouse_button_event := event as InputEventMouseButton
	if mouse_button_event == null: return
	if mouse_button_event.button_index != 1: return
	if mouse_button_event.pressed != true: return
	bounce()
	pass # Replace with function body.
