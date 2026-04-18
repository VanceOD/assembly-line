class_name MaterialBody
extends CharacterBody3D

@export var material_name = ""

var is_held = false
var gravity = Vector3(0.0, -9.81, 0.0)

func _physics_process(delta: float) -> void:
	if is_held: return
	velocity += gravity * delta
	move_and_slide()
