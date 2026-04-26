class_name Volcano
extends CharacterBody3D

@export var activity := 30.0
@export var deactivation_speed := 6.8
@export var activation_speed := 80.0
@export var lava_noise: AudioStreamPlayer3D
@export var mesh_instance: MeshInstance3D


var stored_activity := 0.0

func increase_activity() -> void: stored_activity += 30.0

func random_vector(intensity := 0.02) -> Vector3:
	var x := randf_range(-intensity, intensity)
	var y := randf_range(-intensity, intensity)
	var z := randf_range(-intensity, intensity)
	var result := Vector3(x, y, z)
	return result

## Shake the 3D node a specified number of frames by a specified intensity each frame.
func shake(node: Node3D, frames := 3, intensity := 0.02) -> void:
	var stored_position := node.position
	for i in frames:
		node.position = stored_position + random_vector(intensity)
		await get_tree().physics_frame
	node.position = stored_position
	

func _physics_process(delta: float) -> void:
	# Build activity
	if stored_activity > 0.0:
		var amount_to_increase := clampf(activation_speed * delta, 0.0, stored_activity)
		activity += amount_to_increase
		stored_activity -= amount_to_increase
	
	# Physics
	velocity += get_gravity() * delta
	move_and_slide()
	
	# Volcano Activity
	activity -= deactivation_speed * delta
	activity = clampf(activity, 0.0, 125.0)
	
	# Lava Volume
	var minimum_db := -40.0
	var maximum_db := 0.0
	var volume_db_range := maximum_db - minimum_db
	var activity_percentage := activity / 125.0
	var target_volume_db := minimum_db + (volume_db_range * activity_percentage)
	lava_noise.volume_db = target_volume_db

func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	var mouse_button_input := event as InputEventMouseButton
	if mouse_button_input == null: return
	if mouse_button_input.button_index != 1: return
	if mouse_button_input.pressed != true: return
	increase_activity()
	shake(mesh_instance)
