extends Node3D

enum State {
	CHOOSING_JOB,
	ASSEMBLY_LINE,
	CIRCUIT_BOARD,
	CODE_BOX,
	INSPECTING_PRODUCT
}

var state = State.CHOOSING_JOB
var requested_state = State.CHOOSING_JOB
var machine_reward = "dud"

func request_state(new_state: State):
	requested_state = new_state

func _ready() -> void:
	pass
	#await get_tree().create_timer(5).timeout
	#$CameraPivot.move_to_marker($CircuitBoardFocalPoint)
	#await get_tree().create_timer(5).timeout
	#$CameraPivot.move_to_marker($CodeBoxFocalPoint)
	#await get_tree().create_timer(5).timeout
	#$CameraPivot.move_to_marker($AssemblyLineFocalPoint)

func _physics_process(delta: float) -> void:
	match state:
		State.CHOOSING_JOB:
			if requested_state == State.ASSEMBLY_LINE:
				state = requested_state
				$CameraPivot.move_to_marker($AssemblyLineFocalPoint)
				$AssemblyLine.reset_assembly_line()
		State.ASSEMBLY_LINE:
			if requested_state == State.CIRCUIT_BOARD:
				state = requested_state
				$CameraPivot.move_to_marker($CircuitBoardFocalPoint)
		State.CIRCUIT_BOARD:
			if requested_state == State.CODE_BOX:
				state = requested_state
				$CameraPivot.move_to_marker($CodeBoxFocalPoint)
		State.CODE_BOX:
			if requested_state == State.INSPECTING_PRODUCT:
				state = requested_state
				$CameraPivot.move_to_marker($InspectionFocalPoint)
		State.INSPECTING_PRODUCT:
			if requested_state == State.CHOOSING_JOB:
				state = requested_state
				$CameraPivot.move_to_marker($JobBoardFocalPoint)

func _on_job_board_job_selected(job_name: Variant) -> void:
	if state != State.CHOOSING_JOB: return
	match job_name:
		"Job 1":
			$AssemblyLine.generate_schematics(["gear", "chip"], 3)
			$CodeBox.reset_code_box()
			$CodeBox.generate_sequence(["back", "loop"], ["back", "loop", "start"])
			machine_reward = "dud"
			pass
		"Job 2":
			pass
		"Job 3":
			pass
	$CircuitBoard.spawn_puzzle(job_name)
	request_state(State.ASSEMBLY_LINE)
	$InventionDispenser.clear_invention()

func _on_assembly_line_finished() -> void:
	request_state(State.CIRCUIT_BOARD)


func _on_circuit_board_finished() -> void:
	request_state(State.CODE_BOX)


func _on_code_box_finished() -> void:
	print("Finished Code")
	request_state(State.INSPECTING_PRODUCT)
	await get_tree().create_timer(2.0).timeout
	$InventionDispenser.activate(machine_reward)
	await get_tree().create_timer(3.0).timeout
	$BackButton.visible = true
	pass # Replace with function body.


func _on_back_button_pressed() -> void:
	request_state(State.CHOOSING_JOB)
	$BackButton.visible = false
