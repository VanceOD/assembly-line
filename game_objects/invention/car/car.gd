class_name Car
extends CharacterBody3D

enum State {
	IDLE,
	MOVING_FORWARD,
	MOVING_BACKWARD
}

var state := State.IDLE
var speed := 1.0
var accel := 1.0
var turn_speed := 0.6
var forward_pressed := false
var backwards_pressed := false

func accelerate_model(speed_value := 1.0, delta := 1.0 / 30.0) -> void:
	var horizontal_velocity := Vector2(velocity.x, velocity.z)
	var forward_velocity := Vector2.from_angle(-rotation.y + (PI / 2)) * speed_value
	var target_horizontal_velocity := horizontal_velocity.move_toward(forward_velocity, accel * delta)
	velocity.x = target_horizontal_velocity.x
	velocity.z = target_horizontal_velocity.y

func _physics_process(delta: float) -> void:
	match state:
		State.IDLE:
			velocity += get_gravity() * delta
			accelerate_model(0.0, delta)
			if forward_pressed == true:
				state = State.MOVING_FORWARD
				forward_pressed = false
				print("Switching to moving forward")
				return
			if backwards_pressed == true:
				state = State.MOVING_BACKWARD
				backwards_pressed = false
				print("Switching to moving backward")
				return
		State.MOVING_FORWARD:
			velocity += get_gravity() * delta
			accelerate_model(speed, delta)
			if forward_pressed == true:
				state = State.IDLE
				forward_pressed = false
				print("Switching to idle")
				return
			if backwards_pressed == true:
				state = State.MOVING_BACKWARD
				backwards_pressed = false
				print("Switching to moving_back")
				return
		State.MOVING_BACKWARD:
			velocity += get_gravity() * delta
			accelerate_model(-speed, delta)
			rotation.y += turn_speed * delta
			if forward_pressed == true:
				state = State.MOVING_FORWARD
				forward_pressed = false
				return
			if backwards_pressed == true:
				state = State.IDLE
				backwards_pressed = false
				return
	move_and_slide()
