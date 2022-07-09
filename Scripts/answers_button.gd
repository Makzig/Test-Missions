extends Button


var truth_answer : bool = false

signal Answer_pressed(right_answer)

func _on_answers_button_pressed():
	emit_signal("Answer_pressed", truth_answer )
