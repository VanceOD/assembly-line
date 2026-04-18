extends Node3D

signal cooldown_complete

enum State {
	READY,
	SHOWING,
	COOLDOWN
}

const BATTERY = preload("uid://dugts53t3y5wu")
const BOLT = preload("uid://dx56ve2ouf7yd")
const CHIP = preload("uid://dliwp5tnipqvj")
const GEAR = preload("uid://c0umsjdqfjm2q")
const SPRING = preload("uid://bm3eedmkxhhdl")

var state = State.READY
var materials_to_show = []
var hint_timer = 0.0

func display_materials(materials = {}):
	if state != State.READY: return
	var material_array = []
	for item in materials:
		for i in range(materials[item]):
			material_array.append(item)
	var spacing = 0.4
	var offset = Vector3(spacing, 0.0, 0.0)
	var size_of_space = (material_array.size() - 1) * spacing
	var spawn_point = Vector3(-size_of_space / 2, 0.0, 0.0)
	for item in material_array:
		spawn_material(item, spawn_point)
		spawn_point += offset
	hint_timer = 4.0
	state = State.SHOWING

func spawn_material(material = "battery", new_pos = Vector3.ZERO):
	var result: MaterialBody
	match material:
		"battery":
			result = BATTERY.instantiate() as MaterialBody
		"bolt":
			result = BOLT.instantiate() as MaterialBody
		"chip":
			result = CHIP.instantiate() as MaterialBody
		"gear":
			result = GEAR.instantiate() as MaterialBody
		"spring":
			result = SPRING.instantiate() as MaterialBody
	result.position = new_pos
	result.is_held = true
	add_child(result)

func clear_material_hint():
	for child in get_children():
		child.queue_free()

func _process(delta: float) -> void:
	match state:
		State.READY:
			pass
		State.SHOWING:
			if hint_timer > 0:
				hint_timer -= delta
				return
			state = State.COOLDOWN
			clear_material_hint()
			hint_timer = 10.0
		State.COOLDOWN:
			if hint_timer > 0:
				hint_timer -= delta
				return
			state = State.READY
			cooldown_complete.emit()
