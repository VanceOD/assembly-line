extends Area3D

signal remote_button_pressed

func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	var input_event_mouse_button := event as InputEventMouseButton
	if input_event_mouse_button == null: return
	if input_event_mouse_button.button_index != 1: return
	if input_event_mouse_button.pressed == false: return
	remote_button_pressed.emit()
	$"../ClickSoundEffect".play()
