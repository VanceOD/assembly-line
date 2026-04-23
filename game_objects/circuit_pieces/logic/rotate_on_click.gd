extends CharacterBody3D

@export var slide_sound: AudioStreamPlayer3D

var tween: Tween
var is_rotating = false
var can_rotate = true

func rotate_piece():
	if is_rotating: return
	if not can_rotate: return
	is_rotating = true
	if slide_sound != null:
		slide_sound.play()
	if tween:
		tween.kill()
	tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	var target_rotation = rotation.y + (PI / 2)
	tween.tween_property(self, "rotation:y", target_rotation, 0.20)
	tween.tween_property(self, "is_rotating", false, 0.0)

func freeze_piece():
	can_rotate = false

func _ready() -> void:
	collision_layer = 8
	collision_mask = 0
	input_event.connect(_on_input_event)

func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	# Rotates the piece when it's tapped on.
	var mouse_button_event = event as InputEventMouseButton
	if mouse_button_event == null: return
	if mouse_button_event.button_index == 1 and mouse_button_event.pressed == true: rotate_piece()
