extends Area2D

var direction = Vector2.LEFT # makes the cars move left 
var speed = 100 

func _ready() -> void: 
	if position.x < 0: # then we know we're on the left side
		direction.x = 1 # and we switch it to the right side 
		$Sprite2D.flip_h = true 

func _process(delta: float) -> void: 
	position += direction * speed * delta # we're updating the position of this area2d node 
	# why use process for car but physics process for player? because the cars DON'T have collisions while the player DOES. if the player collides with a car, the game ends right away
	"""
	okay so wth is delta? 
	basically, delta is a way to stabilize the speed of a game. usually games are calculated in movement per frame and in frames per second, so 60 movements per frame with 50 frames per second means that youre player will be moving a helluva lot faster than 60 movements per frame with 10 frames per second. 
	delta basically stabilizes it so that the # of movements are the same 
	and the best thing: the way to enable delta time is to just... multiply the position by delta lol. that's it.
	https://www.youtube.com/watch?v=TLG2yVpLDT8&t=15s 3:35:19 has a graph about it 
	"""
	


func _on_visible_on_screen_notifier_2d_screen_exited(): # connected a signal on this node called "screen_exited" 
	# basically, when we spawn cars, we spawn them infinitely, and that can get reaaaaally problematic
	# so we want to get rid of cars as soon as they leave the screen. thus, we use this child node and this signal to get rid of the cars when they leave the scene 
	queue_free() # this destroys the current instance of the node, which means as soon as the car leaves the screen, we're destroying it 
