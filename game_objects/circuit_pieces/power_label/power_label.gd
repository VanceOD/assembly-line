class_name PowerLabel
extends Label3D

const HIDDEN_POSITION := Vector3(0.0, 0.0, 0.0)
const OVERSHOT_POSITION := Vector3(0.0, 0.210, 0.0)
const SHOWN_POSITION := Vector3(0.0, 0.120, 0.0)
const HIDDEN_SIZE := Vector3(0.10, 0.10, 0.10)
const SHOWN_SIZE := Vector3(1.0, 1.0, 1.0)

var tween: Tween

func hide_power() -> void:
	if tween:
		tween.kill()
	tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "position", OVERSHOT_POSITION, 0.10)
	tween.tween_property(self, "position", HIDDEN_POSITION, 0.10)
	tween.parallel().tween_property(self, "scale", HIDDEN_SIZE, 0.10)
	tween.tween_property(self, "visible", false, 0.0)

func show_power(value: int) -> void:
	if tween:
		tween.kill()
	tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "text", str(value), 0.0)
	tween.tween_property(self, "visible", true, 0.0)
	tween.tween_property(self, "position", OVERSHOT_POSITION, 0.10)
	tween.parallel().tween_property(self, "scale", SHOWN_SIZE * 1.30, 0.10)
	tween.tween_property(self, "position", SHOWN_POSITION, 0.10)
	tween.parallel().tween_property(self, "scale", SHOWN_SIZE, 0.10)
