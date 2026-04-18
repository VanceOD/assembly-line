extends Node3D

signal finished

const PUZZLE_1 = preload("uid://41kwokgp08ol")

func clear_puzzle():
	for child in get_children():
		child.queue_free()

func spawn_puzzle(job = "Job 1"):
	clear_puzzle()
	var puzzle: Puzzle
	match job:
		"Job 1":
			puzzle = PUZZLE_1.instantiate() as Puzzle
	if puzzle == null: return
	puzzle.puzzle_completed.connect(_on_puzzle_complete)
	add_child(puzzle)
	print("Puzzle added successfully")

func _on_puzzle_complete():
	finished.emit()
