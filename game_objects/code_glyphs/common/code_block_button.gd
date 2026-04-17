class_name CodeBlockButton
extends CharacterBody3D

signal button_pressed(glyph_command)

@export var command = ""

func _ready() -> void:
	input_event.connect(_on_input_event)
	pass


func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	var mouse_button_event = event as InputEventMouseButton
	if mouse_button_event == null: return
	if mouse_button_event.button_index != 1: return
	if mouse_button_event.pressed != true: return
	button_pressed.emit(command)
	print("Command %s" % command)
