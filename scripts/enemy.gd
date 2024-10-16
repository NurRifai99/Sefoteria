extends CharacterBody2D

var speed = 30
var playa = null
var player_chase = false

var health = 50
var player_inattack_zone = false

var can_take_damage = true

func _physics_process(delta):
	deal_with_damage()
	
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

func enemy():
	pass


func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_inattack_zone = true

func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_inattack_zone = false

func deal_with_damage():
	if player_inattack_zone and Global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20
			$take_damage_cooldown.start()
			can_take_damage = false
			print("slime health : ",health)
			if health <= 0 :
				self.queue_free()


func _on_take_damage_cooldown_timeout() -> void:
	can_take_damage = true # Replace with function body.
