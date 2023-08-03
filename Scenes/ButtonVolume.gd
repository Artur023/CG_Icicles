extends CheckButton

export var button_state = false;

func _toggled(button_pressed):
	button_state = button_pressed
