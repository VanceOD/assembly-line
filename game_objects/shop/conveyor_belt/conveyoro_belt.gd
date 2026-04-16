extends Node3D

const CONVEYOR_SLAT = preload("uid://cb2bxl2l8gspo")

func spawn_first_slat():
	var conveyor_slat = CONVEYOR_SLAT.instantiate() as CharacterBody3D
	conveyor_slat.position = $FirstSpawn.position
	add_child(conveyor_slat)

func _ready() -> void:
	spawn_first_slat()

func _on_active_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("conveyor_slats"):
		var offset = Vector3(-0.4, 0.0, 0.0)
		var conveyor_slat = CONVEYOR_SLAT.instantiate() as CharacterBody3D
		conveyor_slat.position = body.position + offset
		add_child(conveyor_slat)


func _on_active_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("conveyor_slats"):
		body.queue_free()
