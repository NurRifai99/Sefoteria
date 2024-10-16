extends CharacterBody2D

var speed = 35
var playa = null
var player_chase = false

func _physics_process(delta):
	if player_chase :
		position += (playa.position - position).normalized() * speed * delta
		move_and_collide(Vector2(0,0)) 
		$AnimatedSprite2D.play("walk")
		if(playa.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
			
	else:
		$AnimatedSprite2D.play("idle")
		
func _on_area_2d_body_entered(body):
	playa = body
	player_chase = true



func _on_area_2d_body_exited(body) -> void:
	player_chase = false
	playa = null
