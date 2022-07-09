extends Control

export var lives = 3 

var score : int = 0


signal Lose

func _ready():
	while lives > $Lives.get_child_count():
		$Lives.add_child(load("res://Scenes/Heart.tscn").instance())




func set_score(_text : String):
	$Score.text = _text

func set_live(value):
	lives = value
	
	if value < $Lives.get_child_count():
		var heart = $Lives.get_child(0)
		heart.queue_free()
	
	if lives <= 0:
		emit_signal("Lose")
