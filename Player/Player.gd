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
	
func _process(delta):
	player_attack()
	
func _physics_process(delta):
	player_walk()
	move_and_slide(velocity)
	
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
	if Input.is_action_pressed("attack"):
		isAttacking = true
		$AnimatedSprite.play("attack")

func _on_AnimatedSprite_animation_finished():
	isAttacking = false
	$AnimatedSprite.stop()

