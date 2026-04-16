extends Area3D

var materials: Array[String]


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("material"):
		materials.append(body.get("material_name"))
		print(materials)
