extends Node3D

signal finished()

var required_parts = ["spring", "gear"]
var collected_parts = []

func reset_assembly_line():
	$Chute.clear_materials()
	collected_parts = []
	await get_tree().create_timer(2).timeout
	$HintButton.set_cooldown()
	show_hint()

func generate_schematics(part_names = ["spring", "gear"], count = 3):
	var rand_i_range = part_names.size() - 1
	var result = []
	for i in range(count):
		var part_name = part_names[randi_range(0, rand_i_range)]
		result.append(part_name)
	required_parts = result
	print(required_parts)

func show_hint():
	var tally_of_collected = tally_parts(collected_parts)
	var tally_of_requirements = tally_parts(required_parts)
	var missing_parts = get_missing_material(tally_of_collected, tally_of_requirements)
	$Hints.display_materials(missing_parts)

func check_requirements(list_of_materials):
	var tally_of_collected = tally_parts(list_of_materials)
	var tally_of_requirements = tally_parts(required_parts)
	if is_requirement_met(tally_of_collected, tally_of_requirements):
		finished.emit()

func tally_parts(list_of_materials = []):
	var tally = {}
	for item in list_of_materials:
		var count = tally.get(item, 0)
		count += 1
		tally.set(item, count)
	return tally

func is_requirement_met(collected = {}, requirement = {}):
	var is_met = true
	for item in requirement:
		if collected.get(item, 0) < requirement.get(item, 0):
			is_met = false
			break
	return is_met

func get_missing_material(collected = {}, requirement = {}):
	var needed = {}
	for item in requirement:
		needed.set(item, requirement.get(item, 0) - collected.get(item, 0))
	return needed

func _on_materials_gathered():
	finished.emit()

func _on_chute_material_collected(list_of_materials: Variant) -> void:
	check_requirements(list_of_materials)
	collected_parts = list_of_materials

func _on_hint_button_button_pressed() -> void:
	show_hint()

func _on_hints_cooldown_complete() -> void:
	$HintButton.set_ready()
