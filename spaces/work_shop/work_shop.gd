extends Node3D

enum State {
	CHOOSING_JOB,
	ASSEMBLY_LINE,
	CIRCUIT_BOARD,
	CODE_BOX,
	INSPECTING_PRODUCT
}

const PATH := "user://save.dat"
const JOB_TUTORIAL = preload("uid://b4xy6ohydic5c")
const ASSEMBLY_LINE_TUTORIAL = preload("uid://bntpteii84nag")
const CIRCUIT_TUTORIAL = preload("uid://br1rlww2bjws0")
const CODING_TUTORIAL = preload("uid://cbp4yjs0wy2og")
const INSPECTION_TABLE_TUTORIAL = preload("uid://djl1g8ekkij4i")
const CREDIT_SCRENE = preload("uid://ds84bouqa2hrk")

var state = State.CHOOSING_JOB
var requested_state = State.CHOOSING_JOB
var machine_reward = "dud"
var job_to_unlock = "job_1"
var is_help_pressed := false

var data := {
	"unlocked_jobs": ["job_1"]
}

func request_state(new_state: State):
	requested_state = new_state

func load_data() -> void:
	# Check if file exists.
	if not FileAccess.file_exists(PATH):
		print_debug("Save data does not exists")
		return
	
	# Load file if it exists.
	var file := FileAccess.open(PATH, FileAccess.READ)
	if file.get_error() != OK:
		print_debug("Loading failed")
		return
	data = file.get_var()
	file.close()

func save_data() -> void:
	# Save file to user directory
	var file := FileAccess.open(PATH, FileAccess.WRITE)
	if file.get_error() != OK:
		print_debug("Save failed")
		return
	file.store_var(data)
	file.close()

func _ready() -> void:
	if OS.has_feature("web"):
		$Credits.position -= Vector2(150.0, 0.0)
		$BackButton.position -= Vector2(150.0, 0.0)
	#elif OS.has_feature("android"):
		#$BackButton.position -= Vector2(20.0, 20.0)
		#$Credits.position -= Vector2(20.0, 20.0)
		#$HelpButton.position += Vector2(20.0, -20.0)
	return_to_job_board()
	load_data()
	if data.get("unlocked_jobs", []) is Array:
		$JobBoard.load_job_array(data.get("unlocked_jobs"))
	await get_tree().create_timer(1.0).timeout
	$ScreenFade.fade_in()
	await get_tree().create_timer(0.40).timeout
	$BackgroundMusic.play()

func _physics_process(_delta: float) -> void:
	match state:
		State.CHOOSING_JOB:
			if requested_state == State.ASSEMBLY_LINE:
				state = requested_state
				$CameraPivot.move_to_marker($AssemblyLineFocalPoint)
				$AssemblyLine.reset_assembly_line()
				$BackButton.visible = true
				$Credits.visible = false
				return
			if is_help_pressed == true:
				add_child(JOB_TUTORIAL.instantiate())
				is_help_pressed = false
				return
		State.ASSEMBLY_LINE:
			if requested_state == State.CIRCUIT_BOARD:
				state = requested_state
				$CameraPivot.move_to_marker($CircuitBoardFocalPoint)
				return
			if is_help_pressed == true:
				add_child(ASSEMBLY_LINE_TUTORIAL.instantiate())
				is_help_pressed = false
				return
			if requested_state == State.CHOOSING_JOB: return_to_job_board()
		State.CIRCUIT_BOARD:
			if requested_state == State.CODE_BOX:
				state = requested_state
				$CameraPivot.move_to_marker($CodeBoxFocalPoint)
				return
			if is_help_pressed == true:
				add_child(CIRCUIT_TUTORIAL.instantiate())
				is_help_pressed = false
				return
			if requested_state == State.CHOOSING_JOB: return_to_job_board()
		State.CODE_BOX:
			if requested_state == State.INSPECTING_PRODUCT:
				state = requested_state
				$CameraPivot.move_to_marker($InspectionFocalPoint)
				await get_tree().create_timer(2.0).timeout
				$InventionDispenser.activate(machine_reward)
				return
			if is_help_pressed == true:
				add_child(CODING_TUTORIAL.instantiate())
				is_help_pressed = false
				return
			if requested_state == State.CHOOSING_JOB: return_to_job_board()
		State.INSPECTING_PRODUCT:
			if requested_state == State.CHOOSING_JOB:
				return_to_job_board()
				#$BackButton.visible = false
				#state = requested_state
				#$CameraPivot.move_to_marker($JobBoardFocalPoint, Vector3(0.0, 0.0, 0.0))
				$JobBoard.unlock_job(job_to_unlock)
				var my_jobs = data["unlocked_jobs"] as Array
				if not my_jobs.has(job_to_unlock):
					my_jobs.append(job_to_unlock)
					data["unlocked_jobs"] = my_jobs
					save_data()
				return
			if is_help_pressed == true:
				add_child(INSPECTION_TABLE_TUTORIAL.instantiate())
				is_help_pressed = false
				return

func _on_job_board_job_selected(job_name: Variant) -> void:
	if state != State.CHOOSING_JOB: return
	match job_name:
		"Job 1":
			$AssemblyLine.generate_schematics(["gear", "chip"], 2)
			$CodeBox.reset_code_box()
			$CodeBox.generate_sequence(["back", "loop"], ["back", "loop", "start"])
			machine_reward = "pin_wheel"
			job_to_unlock = "job_2"
		"Job 2":
			$AssemblyLine.generate_schematics(["gear", "spring", "battery"], 3)
			$CodeBox.reset_code_box()
			$CodeBox.generate_sequence(["break", "continue", "start"], ["break", "continue", "start"])
			machine_reward = "ball"
			job_to_unlock = "job_3"
		"Job 3":
			$AssemblyLine.generate_schematics(["spring", "chip", "battery"], 5)
			$CodeBox.reset_code_box()
			$CodeBox.generate_sequence(["back", "decrease", "join", "split"], ["back", "decrease", "join", "split", "break"])
			machine_reward = "volcano"
			job_to_unlock = "job_4"
		"Job 4":
			$AssemblyLine.generate_schematics(["chip", "bolt", "battery"], 7)
			$CodeBox.reset_code_box()
			$CodeBox.generate_sequence(["back", "break", "continue", "decrease", "increase", "join"], ["back", "break", "continue", "decrease", "increase", "join"])
			machine_reward = "ufo"
			job_to_unlock = "job_5"
		"Job 5":
			$AssemblyLine.generate_schematics(["gear", "chip", "bolt", "battery", "spring"], 10)
			$CodeBox.reset_code_box()
			$CodeBox.generate_sequence(["back", "break", "continue", "decrease", "increase", "join", "loop", "pause", "split", "start"], ["back", "break", "continue", "decrease", "increase", "join", "loop", "pause", "split", "start"])
			machine_reward = "car"
			job_to_unlock = "job_5"
	$CircuitBoard.spawn_puzzle(job_name)
	request_state(State.ASSEMBLY_LINE)
	$InventionDispenser.clear_invention()

func return_to_job_board():
	$BackButton.visible = false
	$Credits.visible = true
	state = requested_state
	$CameraPivot.move_to_marker($JobBoardFocalPoint, Vector3(-10.0, 0.0, 0.0))

func _on_assembly_line_finished() -> void:
	request_state(State.CIRCUIT_BOARD)

func _on_circuit_board_finished() -> void:
	request_state(State.CODE_BOX)

func _on_code_box_finished() -> void:
	request_state(State.INSPECTING_PRODUCT)

func _on_back_button_pressed() -> void:
	request_state(State.CHOOSING_JOB)
	$AssemblyLine.hide_hint_early()

func _on_help_button_pressed() -> void:
	is_help_pressed = true

func _on_credits_pressed() -> void:
	add_child(CREDIT_SCRENE.instantiate())
