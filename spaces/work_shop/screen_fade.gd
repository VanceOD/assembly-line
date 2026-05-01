extends ColorRect

func _ready() -> void:
	visible = true

func fade_in():
	var tween = get_tree().create_tween().bind_node(self)
	visible = true
	tween.tween_property(self, "modulate", Color(0.0, 0.0, 0.0, 0.0), 1.50)
	tween.tween_property(self, "visible", false, 0.0)

func fade_out():
	visible = true
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(self, "modulate", Color(0.0, 0.0, 0.0, 1.0), 1.50)
