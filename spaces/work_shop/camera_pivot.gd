extends Marker3D


func move_to_marker(marker: Marker3D):
	var tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "global_position", marker.global_position, 1.50)
