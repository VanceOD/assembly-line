class_name RemoteController
extends CharacterBody3D

signal forward_pressed
signal backwards_pressed

func _ready() -> void:
	var remote_control_marker := get_tree().get_first_node_in_group("remote_control_marker") as Marker3D
	if remote_control_marker != null: move_toward_marker(remote_control_marker)
	pass

func move_toward_marker(marker: Marker3D) -> void:
	var tween := get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "global_position", marker.global_position, 0.50)
	tween.parallel().tween_property(self, "global_rotation", marker.global_rotation, 0.0)

func _on_forward_area_remote_button_pressed() -> void:
	forward_pressed.emit()
	$remote_controller/ForwardButton.depress()

func _on_backward_area_remote_button_pressed() -> void:
	backwards_pressed.emit()
	$remote_controller/BackButton.depress()
