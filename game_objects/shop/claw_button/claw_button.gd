extends Node3D

signal button_pressed

@export var claw: Claw

var can_press = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_pressed.connect(claw._on_grab_button_pressed)


func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if can_press == false: return
	var mouse_button_event = event as InputEventMouseButton
	if mouse_button_event == null: return
	if mouse_button_event.button_index != 1: return
	if mouse_button_event.pressed != true: return
	button_pressed.emit()
	can_press = false
	$AnimationPlayer.play("button_pressed")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "button_pressed":
		can_press = true
