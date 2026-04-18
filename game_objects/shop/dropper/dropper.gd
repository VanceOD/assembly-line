extends Node3D

enum MaterialType {
	BATTERY,
	BOLT,
	CHIP,
	GEAR,
	SPRING
}

const BATTERY = preload("uid://dugts53t3y5wu")
const BOLT = preload("uid://dx56ve2ouf7yd")
const CHIP = preload("uid://dliwp5tnipqvj")
const GEAR = preload("uid://c0umsjdqfjm2q")
const SPRING = preload("uid://bm3eedmkxhhdl")

@export var battery_weight := 1
@export var bolt_weight := 1
@export var chip_weight := 1
@export var gear_weight := 1
@export var spring_weight := 1

@export var minimum_delay := 0.50
@export var maximum_delay := 1.75

var drop_table: Array[MaterialType]

func fill_drop_table():
	drop_table.clear()
	for i in range(battery_weight):
		drop_table.append(MaterialType.BATTERY)
	for i in range(bolt_weight):
		drop_table.append(MaterialType.BOLT)
	for i in range(chip_weight):
		drop_table.append(MaterialType.CHIP)
	for i in range(gear_weight):
		drop_table.append(MaterialType.GEAR)
	for i in range(spring_weight):
		drop_table.append(MaterialType.SPRING)

func get_material():
	var material: CharacterBody3D
	var type = randi_range(0, drop_table.size() - 1)
	match drop_table[type]:
		MaterialType.BATTERY: material = BATTERY.instantiate() as CharacterBody3D
		MaterialType.BOLT: material = BOLT.instantiate() as CharacterBody3D
		MaterialType.CHIP: material = CHIP.instantiate() as CharacterBody3D
		MaterialType.GEAR: material = GEAR.instantiate() as CharacterBody3D
		MaterialType.SPRING: material = SPRING.instantiate() as CharacterBody3D
	return material

func spawn_material():
	var material = get_material()
	if material == null: return
	material.position = $SpawnPoint.global_position
	get_tree().root.add_child(material)

func _ready() -> void:
	fill_drop_table()

func _on_spawn_timer_timeout() -> void:
	spawn_material()
	var delay = randf_range(minimum_delay, maximum_delay)
	$SpawnTimer.start(delay)
