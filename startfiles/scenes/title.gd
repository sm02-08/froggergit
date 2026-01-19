extends Control

#func change_scene(): 
	#get_tree().change_scene_to_file("res://scenes/game.tscn")

func _ready() -> void: 
	$HighScore.text = "High score: " + str(Global.score)

func _process(_delta: float) -> void: # process and delta both have the _ because process and delta aren't used here
	if Input.is_action_just_pressed("space"): 
		get_tree().change_scene_to_file("res://scenes/game.tscn")
