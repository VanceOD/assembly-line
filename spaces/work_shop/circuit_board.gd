extends Node3D

signal finished

const PUZZLE_1 = preload("uid://41kwokgp08ol")
const PUZZLE_2 = preload("uid://14a4qdplab5k")
const PUZZLE_3 = preload("uid://ckkamu4vw0mlf")
const PUZZLE_4 = preload("uid://5bua7cxfwtsc")
const PUZZLE_5 = preload("uid://diee4hsmcvh6f")


func clear_puzzle():
	for child in get_children():
		child.queue_free()

func spawn_puzzle(job = "Job 1"):
	clear_puzzle()
	var puzzle: Puzzle
	match job:
		"Job 1": puzzle = PUZZLE_1.instantiate() as Puzzle
		"Job 2": puzzle = PUZZLE_2.instantiate() as Puzzle
		"Job 3": puzzle = PUZZLE_3.instantiate() as Puzzle
		"Job 4": puzzle = PUZZLE_4.instantiate() as Puzzle
		"Job 5": puzzle = PUZZLE_5.instantiate() as Puzzle
		_: puzzle = PUZZLE_1.instantiate() as Puzzle
	if puzzle == null: return
	puzzle.puzzle_completed.connect(_on_puzzle_complete)
	add_child(puzzle)

func _on_puzzle_complete():
	finished.emit()
