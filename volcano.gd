class_name Volcano
extends CharacterBody3D

@export var activity := 30.0
@export var deactivation_speed := 6.8

func increase_activity() -> void: activity += 5.0

func _physics_process(delta: float) -> void:
	# Physics
	velocity += get_gravity() * delta
	move_and_slide()
	
	# Volcano Activity
	activity -= deactivation_speed * delta
	activity = clampf(activity, 0.0, 125.0)

func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	var mouse_button_input := event as InputEventMouseButton
	if mouse_button_input == null: return
	if mouse_button_input.button_index != 1: return
	if mouse_button_input.pressed != true: return
	increase_activity()
