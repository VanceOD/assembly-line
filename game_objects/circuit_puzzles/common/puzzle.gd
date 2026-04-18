class_name Puzzle
extends Node3D

signal puzzle_completed

func _ready() -> void:
	for child in get_children():
		if child.has_signal("end_reached"):
			child.end_reached.connect(_on_end_reached)


func _on_end_reached():
	puzzle_completed.emit()
	print("%s puzzle complete" % name)
