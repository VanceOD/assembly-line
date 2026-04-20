extends Node3D

@export var power_delta = 5
@export var logic: Node

func _ready() -> void:
	logic.power_delta = power_delta

func freeze_piece():
	for child in get_children():
		if child.has_method("freeze_piece"):
			child.freeze_piece()
