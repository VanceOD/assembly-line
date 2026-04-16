extends Node3D

enum Direction {
	UP,
	DOWN
}

enum Phase {
	MOVING_UP,
	MOVING_DOWN
}

var rotation_speed = PI
var phase = Phase.MOVING_UP
var tween: Tween

func tween_float():
	if tween:
		tween.kill()
	tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var target_position: Vector3
	var float_radius = 0.01
	if phase == Phase.MOVING_UP:
		target_position.y = -float_radius
		phase = Phase.MOVING_DOWN
	else:
		target_position.y = float_radius
		phase = Phase.MOVING_UP
	var phase_duration = 0.75
	tween.tween_property(self, "position", target_position, phase_duration)
	tween.tween_callback(tween_float)

func _ready() -> void:
	tween_float()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation.y += rotation_speed * delta
