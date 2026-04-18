class_name Job
extends Node3D

signal job_pressed(job_name)

var label: Label3D

func _ready() -> void:
	for child in get_children():
		if child is Label3D:
			label = child
			


func _on_static_body_3d_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	var mouse_input_event = event as InputEventMouseButton
	if mouse_input_event == null: return
	if mouse_input_event.button_index != 1: return
	if mouse_input_event.pressed != true: return
	job_pressed.emit(label.text)
