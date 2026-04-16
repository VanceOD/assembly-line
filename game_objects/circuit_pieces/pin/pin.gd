class_name Pin
extends Area3D

enum State {
	OFF,
	RECEIVING,
	SENDING
}

var state = State.OFF
var connected_pins: Array[Pin] = []
var power = 0

func _physics_process(_delta: float) -> void:
	match state:
		State.OFF:
			var connected_power = 0
			for pin in connected_pins:
				if pin.state == State.SENDING: connected_power += pin.power
			if connected_power > 0:
				power = connected_power
				state = State.RECEIVING
		State.RECEIVING:
			var connected_power = 0
			for pin in connected_pins:
				if pin.state == State.SENDING: connected_power += pin.power
			if connected_power > 0:
				power = connected_power
			else:
				power = 0
				state = State.OFF
		State.SENDING:
			pass

func charge(value: int):
	match state:
		State.OFF:
			power = value
			if power > 0:
				state = State.SENDING 
		State.SENDING:
			power = value
			if power <= 0:
				state = State.OFF
		State.RECEIVING:
			pass # Do Nothing.

func _on_area_entered(area: Area3D) -> void:
	var pin = area as Pin
	if pin == null: return
	connected_pins.append(pin)

func _on_area_exited(area: Area3D) -> void:
	var pin = area as Pin
	if pin == null: return
	connected_pins.erase(pin)
