extends Area3D

func _on_body_entered(body: Node3D) -> void:
	var material = body as MaterialBody
	if material == null: return
	material.queue_free()
	print("Freeing %s" % material.material_name)
