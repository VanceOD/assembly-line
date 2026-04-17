extends Node3D

signal finished

enum State {
	ACCEPTING_INPUT,
	PARSING_CODE,
	RESETTING,
	FINISHED
}

var current_column = 0
var timer = 0.0
var state = State.ACCEPTING_INPUT
var is_valid = [false, false, false, false, false]
@export var sequence = ["back", "back", "back", "back", "back"]
@export var slots: Array[CodeSlot]
@export var buttons: Array[CodeBlockButton]

func _ready() -> void:
	for button in buttons:
		button.button_pressed.connect(_on_glyph_button_pressed)

func _physics_process(delta: float) -> void:
	match state:
		State.ACCEPTING_INPUT:
			if current_column > 4:
				state = State.PARSING_CODE
				timer = 1.0
				current_column = 0
		State.PARSING_CODE:
			if timer > 0.0:
				timer -= delta
				return
			if current_column > 4:
				if is_valid == [true, true, true, true, true]:
					state = State.FINISHED
					finished.emit()
					return
				else:
					state = State.RESETTING
					timer = 1.75
					current_column = 0
					is_valid = [false, false, false, false, false]
					return
			var command = slots[current_column].parse_command()
			if sequence[current_column] == command:
				slots[current_column].change_glyph("correct")
				is_valid[current_column] = true
			elif sequence.has(command):
				slots[current_column].change_glyph("half_right")
			else:
				slots[current_column].change_glyph("incorrect")
			current_column += 1
			timer = 0.47
		State.RESETTING:
			if timer > 0:
				timer -= delta
				return
			if current_column > 4:
				state = State.ACCEPTING_INPUT
				current_column = 0
				timer = 0
				return
			slots[current_column].reset_command()
			current_column += 1
			timer = 0.12
		State.FINISHED:
			pass

func _on_glyph_button_pressed(command):
	if not state == State.ACCEPTING_INPUT: return
	slots[current_column].set_command(command)
	current_column += 1
