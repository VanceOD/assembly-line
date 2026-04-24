extends MeshInstance3D

@export var rotation_velocity := -5.0
@export var rotation_deceleration := 2.5
@export var spin_speed := -2.50
@export var max_spin_speed := -25.0
@export var audio_stream_player_3d: AudioStreamPlayer3D

func spin():
	rotation_velocity += spin_speed

func _process(delta: float) -> void:
	var target_rotation_velocity = move_toward(rotation_velocity, 0.0, rotation_deceleration * delta)
	rotation_velocity = target_rotation_velocity
	rotation_velocity = clampf(rotation_velocity, max_spin_speed, 0)
	rotation.z += rotation_velocity * delta
	
	# Adjust audio volume
	var spin_percentage := rotation_velocity / max_spin_speed
	var min_volume_db := -60.0
	var max_volume_db := -10
	var volume_db_range := max_volume_db - min_volume_db
	var target_volume_db := min_volume_db + (volume_db_range * spin_percentage)
	audio_stream_player_3d.volume_db = target_volume_db
	var min_pitch_scale := 0.80
	var max_pitch_scale := 2.0
	var pitch_scale_range := max_pitch_scale - min_pitch_scale
	var target_pitch_scale := min_pitch_scale + (pitch_scale_range * spin_percentage)
	audio_stream_player_3d.pitch_scale = target_pitch_scale
