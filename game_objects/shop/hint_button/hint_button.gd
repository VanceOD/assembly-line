extends Node3D

signal button_pressed

enum State {
	READY,
	COOLDOWN
}

const COOLDOWN_MATERIAL = preload("uid://b7dltjt58fpu3")
const READY_MATERIAL = preload("uid://cui8rgawljo6f")

@export var model: MeshInstance3D
@export var mat_index: int

var state = State.READY

func set_cooldown():
	state = State.COOLDOWN
	model.set_surface_override_material(mat_index, COOLDOWN_MATERIAL)

func set_ready():
	state = State.READY
	model.set_surface_override_material(mat_index, READY_MATERIAL)

func _on_static_body_3d_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	var mouse_input_button = event as InputEventMouseButton
	if mouse_input_button == null: return
	if mouse_input_button.pressed != true: return
	if mouse_input_button.button_index != 1: return
	if state == State.COOLDOWN: return
	button_pressed.emit()
	set_cooldown()
