extends Node3D

signal end_reached

func _ready() -> void:
	$TransmissionLogic.end_reached.connect(_on_end_reached)

func _on_end_reached():
	end_reached.emit()
