extends Control


const SQLITE = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")

var data_base 
var data_base_path : String = "res://DataBase/DataBaseForGodot"

var random_answer = null

var questions : Dictionary = {}
var false_answers : Dictionary = {}
var truth_answer : Dictionary = {}

onready var score : int = $Gui.score
onready var health : int = $Gui.lives

var this_quest = 0

onready var answers_arrays : Array = [
	$answers_button,
	$answers_button5,
	$answers_button6,
	$answers_button7,
]

func _ready():
	randomize()
	read_question()
	change_question()
	





func change_question():
	if this_quest != 5:
		
		for i in answers_arrays.size():
		
			answers_arrays[i].truth_answer = false
			answers_arrays[i].text = false_answers[this_quest]
		
		random_answer = answers_arrays[randi() % answers_arrays.size()]
		random_answer.truth_answer = true
	
		$QestionLabel.text = str(questions[this_quest])
		random_answer.text = truth_answer[this_quest]
	elif this_quest == 5:
		get_tree().paused = true
		$WinPopup.show()
		$WinPopup/Label.text = str("You win!" ,'\n', "your score = ", score)



func read_question():
	data_base = SQLITE.new() 
	data_base.path = data_base_path
	
	data_base.open_db()
	var table_name = "Questions"
	
	data_base.query("SELECT * FROM " +  table_name)
	
	for i in range(0, data_base.query_result.size()):
		questions[i] =  data_base.query_result[i]["Quest"]
		false_answers[i] = data_base.query_result[i]["False-answer"]
		truth_answer[i] = data_base.query_result[i]["Answer"]
	
func _input(_event):
	if Input.is_action_just_pressed("Test_button"):
		change_question()


func _on_answers_button_Answer_pressed(right_answer):
	match right_answer:
		true:
			score += 1
			$Gui.set_score(str(score))
		false:
			health -= 1
			$Gui.set_live(health)
	change_question()
	this_quest += 1


func _on_Restart_pressed():
# warning-ignore:return_value_discarded
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_Exit_pressed():
	get_tree().quit()


func _on_Gui_Lose():
	$Lose_popup.show()
	get_tree().paused = true
