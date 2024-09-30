extends Area2D

@onready var animated_sprite = $AnimatedSprite2D

const MAX_DIST = 320
var counter = 0
var speed = 12


var direction = Vector2(0, 0)
func _ready():
	var game_node = get_parent()
	var player = game_node.get_node("Player")
	var xvec = player.last_x_vec
	var yvec = player.last_y_vec
	direction = Vector2(xvec, yvec)

@warning_ignore("unused_parameter")
func _process(delta):
	var velocity = direction * speed
	if counter <= MAX_DIST:
		position[0] += velocity[0]
		position[1] += velocity[1]
		counter += speed
	else:
		animated_sprite.play("explode")
		
		


func animation_finished():
	self.queue_free()
	


func _on_area_entered(area):
	if area.is_in_group("fireball") == false:
		counter = MAX_DIST
		animated_sprite.play("explode")
	
