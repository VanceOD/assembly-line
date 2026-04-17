class_name CodeBlock
extends CharacterBody3D

const GLYPH_WRONG_MATERIAL = preload("uid://8ue6vxkfyqu7")
const GLYPH_HALF_RIGHT_MATERIAL = preload("uid://7hnbvjs78rak")
const GLYPH_RIGHT_MATERIAL = preload("uid://ctywlrlrwybeg")

@export var command = ""

@export var model: MeshInstance3D

func change_glyph(value):
	match value:
		"correct":
			model.set_surface_override_material(1, GLYPH_RIGHT_MATERIAL)
		"half_right", "wrong_spot":
			model.set_surface_override_material(1, GLYPH_HALF_RIGHT_MATERIAL)
		_:
			model.set_surface_override_material(1, GLYPH_WRONG_MATERIAL)
