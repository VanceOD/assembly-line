extends Node3D

@export var initial_charge = 5
@onready var power_label: PowerLabel = $PowerLabel


func _ready() -> void:
	$StartBlockLogic.initial_charge = initial_charge
	power_label.show_power(initial_charge)
