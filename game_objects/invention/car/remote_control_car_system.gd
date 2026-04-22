extends Node3D


func _on_remote_controller_forward_pressed() -> void:
	$Car.forward_pressed = true
	pass # Replace with function body.


func _on_remote_controller_backwards_pressed() -> void:
	$Car.backwards_pressed = true
	pass # Replace with function body.
