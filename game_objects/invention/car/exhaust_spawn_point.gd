extends Marker3D

const CAR_SMOKE = preload("uid://8f2orqes1672")

var smoke_timer := 0.30

func _physics_process(delta: float) -> void:
	if smoke_timer > 0.0:
		smoke_timer -= delta
		return
	
	var car_smoke := CAR_SMOKE.instantiate() as Node3D
	car_smoke.top_level = true
	car_smoke.position = global_position
	add_child(car_smoke)
	smoke_timer = randf_range(0.10, 0.30)
