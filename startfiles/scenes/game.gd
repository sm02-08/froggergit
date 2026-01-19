extends Node2D

#func _ready(): 
	#pass 
	#
#func _process(delta: float): 
	#$Map.scale()

# store the car scene inside the game scene 
var car_scene: PackedScene = preload("res://scenes/car.tscn") # when loading a scene, you always use PackedScene and then preload the tscn 

func _on_area_2d_body_entered(body):
	print("player entered")


func _on_car_timer_timeout():
	var car = car_scene.instantiate() as Area2D # creates an instance of the car scene 
	# why set it to "as Area2D"? because then when you do car.position = pos_marker.position, you're able to get suggestions for positions for Area2D. if you don't set this as Area2D beforehand, you won't get these suggestions from godot since godot won't know what data type car is -- which isn't horrible, but for a beginner, it's easier to have the suggestions ready 
	var pos_marker = $CarStartPositions.get_children().pick_random() as Marker2D # this returns an array of all the child nodes and picks a random one of all car start positions 
	# we have to make the car positions because otherwise the cars would spawn straight in the middle of the road 
	car.position = pos_marker.position 
	# now we add it to the current scene 
	$Objects.add_child(car) # this adds the cars as childs of the Objects scene, which is in the parent node2d of "Game", as opposed to adding the cars as children of the Game Node2D 
	
	car.connect("body_entered", go_to_title)

func go_to_title(body): # why pass in "body" as a parameter? because if you try to do it without any parameters, godot will return a lot of errors in the "Debugger" tab. what are these errors? essentially, without parameters, you'd expect zero inputs. however, when doing the .connect() stuff, you have to pass in "body_entered" and like... that's 1 input when you were expecting zero. so to counteract that, pass in a parameter called "body" 
	print(body) 
	print("Player car collision happened")
