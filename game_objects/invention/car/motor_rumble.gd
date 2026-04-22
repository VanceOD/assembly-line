extends MeshInstance3D

var tween: Tween

func _ready() -> void:
	rumble_down()

func rumble_up() -> void:
	if tween:
		tween.kill()
	tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "position", Vector3(0.0, 0.01, 0.0), 0.1)
	tween.tween_callback(rumble_down)
	pass

func rumble_down() -> void:
	if tween:
		tween.kill()
	tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "position", -Vector3(0.0, 0.01, 0.0), 0.1)
	tween.tween_callback(rumble_up)
	pass
