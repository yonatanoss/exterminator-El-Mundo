extends KinematicBody2D

export var speed = 400  # How fast the player will move (pixels/sec).
var isAttacking = false
var velocity
#player status
var health = 70
var shield
var level
#resources
var gold
var stone
var wood
#tools
var picaxe_lvl
var weapon_lvl
var action_ready = true
	
func _process(delta):
	player_attack()
	
func _physics_process(delta):
	player_walk()
	move_and_slide(velocity)
	if Input.is_action_pressed('ui_action'):
		if action_ready:
			if $RayCast2D.is_colliding():
				if $RayCast2D.get_collider().has_method("hit"):
					action_ready = false
					$ActionTimer.start()
					$RayCast2D.get_collider().hit(self)

func _on_ActionTimer_timeout():
	action_ready = true

	
func player_walk():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		if isAttacking == false:
			$AnimatedSprite.play("walk")
	elif isAttacking == false:
		$AnimatedSprite.stop()
	
func player_attack():
	if Input.is_action_pressed("ui_action"):
		isAttacking = true
		$AnimatedSprite.play("attack")

func _on_AnimatedSprite_animation_finished():
	isAttacking = false
	$AnimatedSprite.stop()

