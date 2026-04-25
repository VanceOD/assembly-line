class_name EngineSoundEffect
extends AudioStreamPlayer3D

const IDLE_VOLUME_DB := -15.0
const RUNNING_VOLUME_DB := -5.0
const REVERSING_VOLUME_DB := -10.0
const IDLE_PITCH_SCALE := 1.0
const RUNNING_PITCH_SCALE := 1.32
const REVERSING_PITCH_SCALE := 1.15
const VOLUME_CHANGE_RATE := 1.0
const PITCH_CHANGE_RATE := 0.75

enum State {
	IDLE,
	RUNNING,
	REVERSING
}

var state := State.IDLE

func set_state_running() -> void:
	state = State.RUNNING

func set_state_idle() -> void:
	state = State.IDLE

func set_state_reversing() -> void:
	state = State.REVERSING

func _physics_process(delta: float) -> void:
	match state:
		State.IDLE:
			volume_db = move_toward(volume_db, IDLE_VOLUME_DB, VOLUME_CHANGE_RATE * delta)
			pitch_scale = move_toward(pitch_scale, IDLE_PITCH_SCALE, PITCH_CHANGE_RATE * delta)
		State.RUNNING:
			volume_db = move_toward(volume_db, RUNNING_VOLUME_DB, VOLUME_CHANGE_RATE * delta)
			pitch_scale = move_toward(pitch_scale, RUNNING_PITCH_SCALE, PITCH_CHANGE_RATE * delta)
		State.REVERSING:
			volume_db = move_toward(volume_db, REVERSING_VOLUME_DB, VOLUME_CHANGE_RATE * delta)
			pitch_scale = move_toward(pitch_scale, REVERSING_PITCH_SCALE, PITCH_CHANGE_RATE * delta)
