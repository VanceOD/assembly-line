extends Node3D

signal button_pressed

const LED_OFF_MATERIAL = preload("uid://dt4jvqd7o0vxv")
const LED_ON_MATERIAL = preload("uid://lbwx68xrkb00")

@export var claw: Claw
@export var led: MeshInstance3D

var can_press = true
var claw_is_busy = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_pressed.connect(claw._on_grab_button_pressed)

func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if can_press == false: return
	var mouse_button_event = event as InputEventMouseButton
	if mouse_button_event == null: return
	if mouse_button_event.button_index != 1: return
	if mouse_button_event.pressed != true: return
	button_pressed.emit()
	can_press = false
	$StaticBody3D/claw_button/AnimationPlayer.play("button_press")
	$AudioStreamPlayer3D.play()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "button_press":
		can_press = true

func set_claw_busy():
	claw_is_busy = true
	led.set_surface_override_material(0, LED_OFF_MATERIAL)

func set_claw_idle():
	claw_is_busy = false
	led.set_surface_override_material(0, LED_ON_MATERIAL)
	$ReadySound.play()
