extends CharacterBody2D

const speed = 100
var current_dir = "none"

func _physics_process(delta):
	player_movement(delta)
	
func player_movement(_delta):
	velocity = Vector2.ZERO  # Reset velocity each frame
	
	if Input.is_action_pressed("move_right"):
		current_dir = "right"
		velocity.x += speed
	elif Input.is_action_pressed("move_left"):
		current_dir = "left"
		velocity.x -= speed

	if Input.is_action_pressed("move_down"):
		current_dir = "down"
		velocity.y += speed
	elif Input.is_action_pressed("move_up"):
		current_dir = "up"
		velocity.y -= speed

	# Normalize the velocity to prevent faster diagonal movement
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		play_anim(1)
	else :
		play_anim(0)

	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
			
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	
	if dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")
	
	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")
		
