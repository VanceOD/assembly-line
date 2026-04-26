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

@export var hint_shown_position: Marker3D
@export var hint_hide_position: Marker3D


var state = State.READY
var materials_to_show = []
var hint_timer = 0.0
var tween: Tween

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
	show_hint()

func show_hint() -> void:
	global_position = hint_hide_position.global_position
	var overshoot_offset := Vector3(0.0, -0.50, 0.0)
	if tween: tween.kill()
	tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "global_position", hint_shown_position.global_position + overshoot_offset, 0.50)
	tween.tween_property(self, "global_position", hint_shown_position.global_position, 0.50)
	pass

func hide_hint() -> void:
	var current_position_stored := global_position
	var overshoot_offset := Vector3(0.0, -0.50, 0.0)
	if tween: tween.kill()
	tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "global_position", current_position_stored + overshoot_offset, 0.50)
	tween.tween_property(self, "global_position", hint_hide_position.global_position, 0.50)
	tween.tween_callback(clear_material_hint)

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
		if child is Marker3D:
			continue
		if child is Label3D:
			continue
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
			hide_hint()
			hint_timer = 10.0
		State.COOLDOWN:
			if hint_timer > 0:
				hint_timer -= delta
				return
			state = State.READY
			cooldown_complete.emit()
