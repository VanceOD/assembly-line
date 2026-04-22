class_name RemoteController
extends CharacterBody3D

signal forward_pressed
signal backwards_pressed

func _on_forward_area_remote_button_pressed() -> void:
	forward_pressed.emit()
	$remote_controller/ForwardButton.depress()

func _on_backward_area_remote_button_pressed() -> void:
	backwards_pressed.emit()
	$remote_controller/BackButton.depress()

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	move_and_slide()
