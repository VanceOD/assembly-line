extends Node

const VOLCANO_SMOKE = preload("uid://b2kr22poq1n7y")
const VOLCANO_SMOKE_DARK = preload("uid://bqey65lgthhps")
const VOLCANO_ROCK = preload("uid://m2x4mp4hwk7q")
const VOLCANO_LAVA = preload("uid://bqntyyujekv67")


@onready var volcano: Volcano = $".."
@onready var spawn_point: Marker3D = $"../SpawnPoint"
var smoke_timer := 0.0
var smoke_dark_timer := 0.0
var rock_timer := 0.0
var lava_timer := 0.0

func random_vector(x_variance := 0.2, y_variance := 0.05, z_variance := 0.2) -> Vector3:
	var x = randf_range(-x_variance, x_variance)
	var y = randf_range(-y_variance, y_variance)
	var z = randf_range(-z_variance, z_variance)
	var result_vector := Vector3(x, y, z)
	return result_vector

func _physics_process(delta: float) -> void:
	if smoke_timer > 0.0:
		smoke_timer -= delta
	else:
		if volcano.activity > 2.0:
			var smoke := VOLCANO_SMOKE.instantiate() as VolcanoSmoke
			smoke.top_level = true
			smoke.position = spawn_point.global_position + random_vector()
			volcano.add_child(smoke)
			var min_timer := 0.15
			var max_timer := 1.0
			var difference := max_timer - min_timer
			var target_timer := max_timer - (difference * (volcano.activity / 125))
			smoke_timer = target_timer
	
	if smoke_dark_timer > 0.0:
		smoke_dark_timer -= delta
	else:
		if volcano.activity > 63.0:
			var smoke := VOLCANO_SMOKE_DARK.instantiate() as VolcanoSmoke
			smoke.top_level = true
			smoke.position = spawn_point.global_position + random_vector()
			volcano.add_child(smoke)
			var min_timer := 0.07
			var max_timer := 1.0
			var difference := max_timer - min_timer
			var target_timer := max_timer - (difference * (volcano.activity / 125))
			smoke_dark_timer = target_timer
	if rock_timer > 0.0:
		rock_timer -= delta
	else:
		if volcano.activity > 38.0:
			var rock := VOLCANO_ROCK.instantiate() as VolcanoRock
			rock.top_level = true
			rock.position = spawn_point.global_position + random_vector()
			volcano.add_child(rock)
			var target_impulse := Vector3(0.0, 3.50, 0.0) + random_vector(1.0, 0.0, 1.0)
			var target_torque_impulse := random_vector(0.05, 0.05, 0.05)
			rock.apply_central_impulse.call_deferred(target_impulse)
			rock.apply_torque_impulse.call_deferred(target_torque_impulse)
			var min_timer := 0.30
			var max_timer := 2.50
			var difference := max_timer - min_timer
			var target_timer := max_timer - (difference * (volcano.activity / 125))
			rock_timer = target_timer
	if lava_timer > 0.0:
		lava_timer -= delta
	else:
		if volcano.activity > 80.0:
			var lava := VOLCANO_LAVA.instantiate() as VolcanoLava
			lava.top_level = true
			lava.position = spawn_point.global_position + random_vector()
			volcano.add_child(lava)
			var target_impulse := Vector3(0.0, 3.50, 0.0) + random_vector(1.0, 0.0, 1.0)
			lava.apply_central_impulse.call_deferred(target_impulse)
			var min_timer := 0.05
			var max_timer := 10.0
			var difference := max_timer - min_timer
			var target_timer := max_timer - (difference * (volcano.activity / 125))
			lava_timer = target_timer
