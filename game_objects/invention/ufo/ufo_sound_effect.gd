extends AudioStreamPlayer3D

const MINIMUM_VOLUME_DB := -50.0
const VOLUME_DB_RANGE := 50.0

var power := 0.0
var _smooth_power := 0.0

func _physics_process(delta: float) -> void:
	# Smoothly transition power
	var delta_power = power - _smooth_power
	_smooth_power += clampf(delta_power, -1.0 * delta, 1.0 * delta)
	
	# Set volume based on power
	var target_volume_db := MINIMUM_VOLUME_DB + (VOLUME_DB_RANGE * _smooth_power)
	volume_db = target_volume_db
