extends Area3D

signal material_grabbed
signal material_dropped

var in_range_materials: Array[CharacterBody3D]

func attempt_grab():
	var nearest_material = get_nearest_material() as CharacterBody3D
	if nearest_material == null: return
	if not nearest_material.is_in_group("material"): return
	nearest_material.get_parent().remove_child(nearest_material)
	nearest_material.position = Vector3.ZERO
	add_child(nearest_material)
	nearest_material.is_held = true
	material_grabbed.emit()
	$GrabSound.play()

func attempt_drop():
	for child in get_children():
		if child.is_in_group("material"):
			child.get_parent().remove_child(child)
			child.position = global_position
			get_tree().root.add_child(child)
			child.is_held = false
			material_dropped.emit()

func get_nearest_material():
	var distance_to_nearest_material = 5000
	var nearest_material = null
	for material in in_range_materials:
		var distance_to_material = global_position.distance_squared_to(material.global_position)
		if distance_to_material < distance_to_nearest_material:
			distance_to_nearest_material = distance_to_material
			nearest_material = material
	return nearest_material

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("material"): in_range_materials.append(body)

func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("material"): in_range_materials.erase(body)
