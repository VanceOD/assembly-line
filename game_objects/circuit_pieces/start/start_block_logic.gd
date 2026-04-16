extends Node

@export var pin: Pin
@export var model: MeshInstance3D
const CONDUCTIVE_MATERIAL_ON = preload("uid://dhb0wny486xg8")

func _ready() -> void:
	model.set_surface_override_material(1, CONDUCTIVE_MATERIAL_ON)

func _process(_delta: float) -> void:
	pin.charge(5)
