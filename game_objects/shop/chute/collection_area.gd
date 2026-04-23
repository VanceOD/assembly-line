extends Area3D

signal material_collected(list_of_materials)

var materials: Array[String]

func reset():
	materials.clear()

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("material"):
		materials.append(body.get("material_name"))
		body.queue_free()
		material_collected.emit(materials)
		$WhooshSound.play()
