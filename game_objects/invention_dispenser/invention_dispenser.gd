class_name InventionDispenser
extends Node3D

const DUD = preload("uid://fia2hi35btkb")
const PIN_WHEEL = preload("uid://yaqr3bbqvsqv")
const BALL = preload("uid://btaddkkqhuckx")


@export var dispense_point: Marker3D
@export var retract_point: Marker3D

func _ready() -> void:
	global_position = retract_point.global_position

func clear_invention():
	for child in get_children():
		if child.name != "chute":
			child.queue_free()

func spawn_invention(invention_name = "dud"):
	var invention: Node3D
	match invention_name:
		"dud": invention = DUD.instantiate() as Node3D
		"pin_wheel": invention = PIN_WHEEL.instantiate() as Node3D
		"ball": invention = BALL.instantiate() as Node3D
		_: invention = DUD.instantiate() as Node3D
	invention.top_level = true
	invention.position = global_position
	add_child(invention)

func activate(invention_name = "dud"):
	var tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "global_position", dispense_point.global_position, 1.0)
	tween.tween_interval(0.50)
	var spawn_proper_invention = spawn_invention.bind(invention_name)
	tween.tween_callback(spawn_proper_invention)
	tween.tween_interval(0.50)
	tween.tween_property(self, "global_position", retract_point.global_position, 1.0)
