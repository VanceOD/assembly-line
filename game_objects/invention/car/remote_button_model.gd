extends MeshInstance3D

var tween: Tween
var default_position: Vector3
var depress_position: Vector3

func _ready() -> void:
	default_position = position
	depress_position = default_position + Vector3(0.0, -0.05, 0.0)

func depress() -> void:
	if tween:
		tween.kill()
	tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "position", depress_position, 0.02)
	tween.tween_property(self, "position", default_position, 0.02)
