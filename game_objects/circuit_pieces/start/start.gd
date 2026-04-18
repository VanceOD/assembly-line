extends Node3D

@export var initial_charge = 5

func _ready() -> void:
	$StartBlockLogic.initial_charge = initial_charge
