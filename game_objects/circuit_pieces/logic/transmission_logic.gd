extends Node

signal end_reached

@export var pins: Array[Pin]
@export var model: MeshInstance3D
@export var power_delta = -1
@export var is_end = false
const CONDUCTIVE_MATERIAL_ON = preload("uid://dhb0wny486xg8")
var total_power = 0
var is_on = false

func _process(_delta: float) -> void:
	# Receive power
	var receiving_power = 0
	for pin in pins:
		if pin.state == Pin.State.RECEIVING:
			receiving_power += pin.power
	if receiving_power > 0: 
		total_power = receiving_power + power_delta
	else:
		total_power = 0
	
	for pin in pins:
		pin.charge(total_power)
	
	match is_on:
		true:
			if not total_power > 0:
				is_on = false
				model.set_surface_override_material(1, null)
				print("%s power off" % get_parent().name)
		false:
			if total_power > 0:
				is_on = true
				model.set_surface_override_material(1, CONDUCTIVE_MATERIAL_ON)
				print("%s power is %s" % [get_parent().name, total_power])
				if is_end:
					end_reached.emit()
					print("End Reached")
