extends Area2D

export var speed = 400  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.
var isAttacking = false
#player status
var health
var shield
var level
#resources
var gold
var stone
var wood
#tools
var picaxe_lvl
var weapon_lvl

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	if isAttacking == false:
		player_walk(delta)
	player_attack()
	
	
func player_walk(delta):
	#var mouse_position = get_local_mouse_position()
	#rotation += mouse_position.angle()
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.stop()

	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
func player_attack():
	if Input.is_action_pressed("attack"):
		isAttacking = true
		$AnimatedSprite.play("attack")

func _on_AnimatedSprite_animation_finished():
	isAttacking = false
	$AnimatedSprite.stop()
