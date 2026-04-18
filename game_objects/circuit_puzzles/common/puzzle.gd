class_name Puzzle
extends Node3D

signal puzzle_completed

func freeze_all():
	for child in get_children():
		if child.has_method("freeze_piece"):
			child.freeze_piece()

func _ready() -> void:
	for child in get_children():
		if child.has_signal("end_reached"):
			child.end_reached.connect(_on_end_reached)


func _on_end_reached():
	puzzle_completed.emit()
	freeze_all()
	print("Finished")
