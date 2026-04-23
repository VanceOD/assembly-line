extends Node3D

signal button_pressed

enum State {
	READY,
	COOLDOWN
}

const BUTTON_MATERIAL = preload("uid://cui8rgawljo6f")
const LED_ON_MATERIAL = preload("uid://lbwx68xrkb00")
const LED_OFF_MATERIAL = preload("uid://dt4jvqd7o0vxv")

@export var led: MeshInstance3D
@export var button: MeshInstance3D
@export var mat_index: int

var state = State.READY

func _ready() -> void:
	led.set_surface_override_material(0, LED_ON_MATERIAL)
	button.set_surface_override_material(0, BUTTON_MATERIAL)
	pass

func set_cooldown():
	state = State.COOLDOWN
	led.set_surface_override_material(0, LED_OFF_MATERIAL)

func set_ready():
	state = State.READY
	led.set_surface_override_material(0, LED_ON_MATERIAL)
	$ReadySound.play()

func _on_static_body_3d_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	var mouse_input_button = event as InputEventMouseButton
	if mouse_input_button == null: return
	if mouse_input_button.pressed != true: return
	if mouse_input_button.button_index != 1: return
	if state == State.COOLDOWN: return
	button_pressed.emit()
	$StaticBody3D/claw_button/AnimationPlayer.play("button_press")
	$AudioStreamPlayer3D.play()
