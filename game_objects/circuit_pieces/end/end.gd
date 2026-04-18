extends Node3D

signal end_reached

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TransmissionLogic.end_reached.connect(_on_end_reached)

func _on_end_reached():
	end_reached.emit()
