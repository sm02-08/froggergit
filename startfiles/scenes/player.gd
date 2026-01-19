extends CharacterBody2D # funny how i couldn't figure out why velocity = ... was returning an error but it was just because you can't extend a Node2D and use move_and_slide with velocity; you have to use CharacterBody2D or 3D yk 

var direction: Vector2 = Vector2(1,1) # the default -- this sets the vector to (this is a matrix so look at it instead of left to write like top to bottom [1 1] 
var speed: int = 100
func _physics_process(_delta: float) -> void: 
	"""
	position += direction * speed # so using the Vector2(1, 0) script, we know that this means the player will be moving to the RIGHT because 1 is the x-value and 0 is the y-value. if it was (1, 1) instead, the player would move diagonally downwards to the right because it moves right 1 and down 1 
	
	print(Input.is_action_pressed("move_right")) # if you do this then the terminal will print "false" all the way until you press the right arrow key or "d" and then the terminal will just print "true" 
	
	^ so that was an intro to position and direction and stuff
	""" 
	#if Input.is_action_pressed("move_right"): 
		#direction = Vector2.RIGHT # this is the same thing as Vector2(1, 0)
	#if Input.is_action_pressed("move_left"): 
		#direction = Vector2.LEFT # same thing as Vector2(-1, 0) 
		#
	#position += direction * speed # so only if you press the right arrow key, the player will move right
	## but for now, the player continuously moves until you press right or left 
	
	# ^ all redundant because we can use a shortcut
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#position += direction * speed 
	velocity = direction * speed 
	animation() # the position of animation in relation to move_and_slide doesn't matter 
	move_and_slide() # this applies the velocity variable above 
	
	if Input.is_action_just_pressed("space"): # if you use is_action_pressed, it checks for space being pressed down at 60 fps. therefore, it's best to change it to is_action_JUST_pressed so that it only checks for one input and doesn't print "something" like 100 times in one press 
		print("something")

func animation(): 
	if direction: # if a direction exists 
		$AnimatedSprite2D.flip_h = direction.x > 0 # this does the same thing as these next 4 highlighted lines:
		"""
		if direction.x > 0:
			$AnimatedSprite2D.flip_h = true # this means that you don't need scripts for the right animation. if you just flip_h on the left animation, you'll move right 
		else: 
			$AnimatedSprite2D.flip_h = false # and if the player is supposed to move left, it'll flip back left
		"""
		if direction.x != 0: 
			$AnimatedSprite2D.animation = 'move_left' # if the player is going to the right, "move_left" will auto become right
		else: # if we're only going up and down...
			$AnimatedSprite2D.animation = 'move_up' if direction.y < 0 else "move_down" # essentially just the same thing as an if direction.y < 0, $AnimatedSprite2D.animation and then else move down, but combined into one 
	else: 
		$AnimatedSprite2D.frame = 0 # if no direction, don't play the animation. this means set the frame to 0
