extends CharacterBody2D

@export var speed = 500

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	#instantiate marker reticle thingy and place it in front of the player
	var marker = preload("res://scenes/marker_2d.tscn")
	var marker_make = marker.instantiate()
	owner.add_child.call_deferred(marker_make)
	var marker_pos_x = position.x + 30
	marker_make.global_position = Vector2(marker_pos_x, position.y)

var input_direction = Vector2(0, 0)
var x_vector = 0
var y_vector = 0
var is_moving = false

#turns on when the player is doing something like teleporting
var mid_action = false

func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	x_vector = input_direction[0]
	y_vector = input_direction[1]
	
	if x_vector > 0:
		animated_sprite.flip_h = false
		
	if x_vector < 0:
		animated_sprite.flip_h = true
	shoot_fireball()

func shoot_fireball():
	var marker = get_node("/root/Game/Marker2D")
	var FIREBALL = preload("res://scenes/fireball.tscn")
	if Input.is_action_just_pressed("click"):
		var b = FIREBALL.instantiate()
		owner.add_child(b)
		var marker_pos = marker.global_position
		b.global_position = marker_pos
		animated_sprite.play("default R")
		animated_sprite.play("shoot_fire R")
		mid_action = true




func animation_tree():
	if mid_action == false:
		if x_vector == 0 and y_vector == 0:
			animated_sprite.play("default R")
			is_moving = false
		else:
			animated_sprite.play("run R")
			is_moving = true


func _on_animated_sprite_2d_animation_finished():
	mid_action = false

func teleport():
	pass
	

func _physics_process(delta):
	get_input()
	move_and_slide()
	animation_tree()





