extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(5).timeout
	$CameraPivot.move_to_marker($CircuitBoardFocalPoint)
	await get_tree().create_timer(5).timeout
	$CameraPivot.move_to_marker($CodeBoxFocalPoint)
	await get_tree().create_timer(5).timeout
	$CameraPivot.move_to_marker($AssemblyLineFocalPoint)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
