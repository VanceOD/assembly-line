extends CharacterBody3D

var power := 0.5
var power_drain_rate := 0.1
var spin_speed := Vector3(0.0, 0.15, 0.0)
@export var upward_thrust := Vector3(0.0, 10.5, 0.0)
@export var spinning_part: MeshInstance3D

func power_up() -> void:
	power += 0.25

func _physics_process(delta: float) -> void:
	power -= power_drain_rate * delta
	power = clampf(power, 0.0, 1.0)
	velocity += get_gravity() * delta
	var lift = upward_thrust * power
	velocity += lift * delta
	move_and_slide()
	spinning_part.rotation += spin_speed * power

func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	var mouse_button_event := event as InputEventMouseButton
	if mouse_button_event == null: return
	if mouse_button_event.pressed != true: return
	if mouse_button_event.button_index != 1: return
	power_up()
