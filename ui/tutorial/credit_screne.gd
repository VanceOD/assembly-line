extends Control

@onready var exit: Button = $VBoxContainer/Exit

func _ready() -> void:
	exit.pressed.connect(queue_free)
