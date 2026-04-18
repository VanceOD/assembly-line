extends Node3D


func freeze_piece():
	for child in get_children():
		if child.has_method("freeze_piece"):
			child.freeze_piece()
