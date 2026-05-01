extends Button

const BUTTON_PRESSED_ICON = preload("uid://cbwkdc0lwk0lq")
const BUTTON_UNPRESSED_ICON = preload("uid://sgopj4hh4flf")
const BUTTON_MOUSE_OVER_ICON = preload("uid://baxbuyqoere6l")

var is_waving := false

func wave(amount := 2) -> void:
	if is_waving: return
	is_waving = true
	var stored_position := position
	var wave_position := position + Vector2(0.0, -30.0)
	var tween_phase_length := 0.50
	var tween := get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	for i in amount:
		tween.tween_property(self, "position", wave_position, tween_phase_length)
		tween.tween_property(self, "position", stored_position, tween_phase_length)
	tween.tween_property(self, "is_waving", false, 0)

func _ready() -> void:
	icon = BUTTON_UNPRESSED_ICON
	icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
	flat = true
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_button_down() -> void:
	icon = BUTTON_PRESSED_ICON

func _on_button_up() -> void:
	icon = BUTTON_UNPRESSED_ICON

func _on_mouse_entered() -> void:
	icon = BUTTON_MOUSE_OVER_ICON

func _on_mouse_exited() -> void:
	if icon == BUTTON_MOUSE_OVER_ICON:
		icon = BUTTON_UNPRESSED_ICON
