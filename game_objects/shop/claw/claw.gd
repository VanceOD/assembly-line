class_name Claw
extends CharacterBody3D

enum ClawState {
	OPEN,
	CLOSED
}

enum State {
	READY,
	GRABBING,
	DROPPING,
	RETURNING
}

@export var target_marker: Marker3D
@export var ready_marker: Marker3D
@export var drop_marker: Marker3D


var tween: Tween
var claw_state = ClawState.CLOSED
var state = State.RETURNING
var is_holding_material = false

func return_to_ready():
	set_state(State.RETURNING)
	if tween: tween.kill()
	tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var ready_position = ready_marker.global_position
	var duration = 1.25
	tween.tween_property(self, "global_position", ready_position, duration)
	tween.tween_callback(close_claw)
	var delay = 0.50
	tween.tween_interval(delay)
	tween.tween_callback(set_state)

func grab():
	set_state(State.GRABBING)
	if tween: tween.kill()
	tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var target_position = target_marker.global_position
	tween.tween_callback(open_claw)
	var duration = 1.50
	tween.tween_property(self, "global_position", target_position, duration)
	tween.tween_callback(close_claw)
	var delay = 0.40
	tween.tween_interval(delay)
	tween.tween_callback($GrabArea.attempt_grab)
	tween.tween_interval(delay)
	tween.tween_callback(resolve)

func drop():
	set_state(State.DROPPING)
	if tween: tween.kill()
	tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var ready_position = ready_marker.global_position
	var drop_position = drop_marker.global_position
	var duration_to_ready = 1.10
	var duration_to_drop = 1.35
	tween.tween_property(self, "global_position", ready_position, duration_to_ready)
	tween.tween_property(self, "global_position", drop_position, duration_to_drop)
	tween.tween_callback(open_claw)
	tween.tween_callback($GrabArea.attempt_drop)
	var delay = 0.50
	tween.tween_interval(delay)
	tween.tween_callback(resolve)

func open_claw():
	if claw_state == ClawState.OPEN: return
	$ModelRoot/claw/AnimationPlayer.play("open")
	claw_state = ClawState.OPEN

func close_claw():
	if claw_state == ClawState.CLOSED: return
	$ModelRoot/claw/AnimationPlayer.play("close")
	claw_state = ClawState.CLOSED

func resolve():
	if state == State.GRABBING:
		if is_holding_material: drop()
		else: return_to_ready()
	elif state == State.DROPPING: return_to_ready()

func set_state(value = State.READY):
	state = value

func _ready() -> void:
	return_to_ready()

func _on_grab_button_pressed() -> void:
	if state == State.READY: grab()

func _on_grab_area_material_dropped() -> void:
	is_holding_material = false

func _on_grab_area_material_grabbed() -> void:
	is_holding_material = true
