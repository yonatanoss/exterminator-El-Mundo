extends Area2D

var screen_size  # Size of the game window.

var shooting_range
var health
var level
var shots_per_s


func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	position.x = 400
	position.y = 300
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	mage_tower_rotate()
	
func mage_tower_rotate():
	var mouse_position = get_local_mouse_position()
	rotation += mouse_position.angle()
