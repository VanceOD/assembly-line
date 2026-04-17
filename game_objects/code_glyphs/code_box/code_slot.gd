class_name CodeSlot
extends Marker3D

const BACK_GLYPH = preload("uid://clbwkjn8vbivq")
const BREAK_GLYPH = preload("uid://bq5hetu8pwgqy")
const CONTINUE_GLYPH = preload("uid://ql3vbldlikqn")
const DECREASE_GLYPH = preload("uid://0f36qrcblfex")
const INCREASE_GLYPH = preload("uid://c870csks171rt")
const JOIN_GLYPH = preload("uid://cit1xlx4k12h1")
const LOOP_GLYPH = preload("uid://bf6k1yroykygy")
const PAUSE_GLYPH = preload("uid://dtp2e7ulsv7as")
const SPLIT_GLYPH = preload("uid://dhvbu0mescjgi")
const START_GLYPH = preload("uid://c2xeewlfx7off")

var command = ""

func set_command(value = ""):
	var glyph: CharacterBody3D
	match value:
		"back":
			glyph = BACK_GLYPH.instantiate() as CharacterBody3D
		"break":
			glyph = BREAK_GLYPH.instantiate() as CharacterBody3D
		"continue":
			glyph = CONTINUE_GLYPH.instantiate() as CharacterBody3D
		"decrease":
			glyph = DECREASE_GLYPH.instantiate() as CharacterBody3D
		"increase":
			glyph = INCREASE_GLYPH.instantiate() as CharacterBody3D
		"join":
			glyph = JOIN_GLYPH.instantiate() as CharacterBody3D
		"loop":
			glyph = LOOP_GLYPH.instantiate() as CharacterBody3D
		"pause":
			glyph = PAUSE_GLYPH.instantiate() as CharacterBody3D
		"split":
			glyph = SPLIT_GLYPH.instantiate() as CharacterBody3D
		"start":
			glyph = START_GLYPH.instantiate() as CharacterBody3D
	
	glyph.position = Vector3(0.0, 5.0, 0.0)
	add_child(glyph)
	var tween = get_tree().create_tween().bind_node(glyph).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(glyph, "position", Vector3.ZERO, 0.50)

func reset_command():
	var code_block: CodeBlock
	for child in get_children():
		code_block = child as CodeBlock
		if code_block == null: continue
		break
	if code_block == null: return
	var tween = get_tree().create_tween().bind_node(code_block).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(code_block, "position", Vector3(0.0, 5.0, 0.0), 0.44)
	tween.tween_callback(code_block.queue_free)

func parse_command():
	var result = ""
	for child in get_children():
		var code_block = child as CodeBlock
		if code_block == null: continue
		result = code_block.command
	return result

func change_glyph(value):
	for child in get_children():
		var code_block = child as CodeBlock
		if code_block == null: continue
		code_block.change_glyph(value)
