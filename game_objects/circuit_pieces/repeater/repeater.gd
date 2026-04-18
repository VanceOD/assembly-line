extends Node3D

@export var power_delta = 5

func _ready() -> void:
	$RotatableBody/RepeaterLogic.power_delta = power_delta
