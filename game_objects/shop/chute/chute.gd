class_name Chute
extends Node3D

signal material_collected(list_of_materials)

func clear_materials():
	$CollectionArea.reset()

func _on_material_collected(list_of_materials: Variant) -> void:
	material_collected.emit(list_of_materials)
