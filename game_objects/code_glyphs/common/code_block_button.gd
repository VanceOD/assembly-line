class_name CodeBlockButton
extends CharacterBody3D

signal button_pressed(glyph_command)

const GLYPH_RIGHT_MATERIAL = preload("uid://ctywlrlrwybeg")
const GLYPH_OFF_MATERIAL = preload("uid://hipqai4wl71i")

@export var command = ""
@export var model: MeshInstance3D
@export var glyph_button_press: AudioStreamPlayer3D

var tween: Tween

func push() -> void:
	if model == null: return
	if glyph_button_press != null:
		glyph_button_press.play()
	if tween:
		tween.kill()
	tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_callback(light_on)
	tween.tween_property(model, "position", Vector3(0.0, -0.05, 0.0), 0.10)
	tween.tween_property(model, "position", Vector3.ZERO, 0.10)
	tween.tween_callback(light_off)

func light_on() -> void:
	if model != null:
		model.set_surface_override_material(1, GLYPH_RIGHT_MATERIAL)
	pass

func light_off() -> void:
	if model != null:
		model.set_surface_override_material(1, GLYPH_OFF_MATERIAL)
	pass

func _ready() -> void:
	input_event.connect(_on_input_event)

func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	var mouse_button_event = event as InputEventMouseButton
	if mouse_button_event == null: return
	if mouse_button_event.button_index != 1: return
	if mouse_button_event.pressed != true: return
	button_pressed.emit(command)
	push()
