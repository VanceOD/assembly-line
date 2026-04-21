extends Area3D

func spin_pin():
	$"../pin_wheel/Handle/Pin".spin()

func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	var mouse_button = event as InputEventMouseButton
	if mouse_button == null: return
	if mouse_button.button_index != 1: return
	if mouse_button.pressed != true: return
	print("It clicked")
	spin_pin()
