extends CharacterBody3D

func _ready() -> void:
	velocity = Vector3(1.0, 0.0, 0.0)

func _physics_process(_delta: float) -> void:
	move_and_slide()
