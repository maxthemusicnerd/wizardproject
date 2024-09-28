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

#timer for various things 
var timer = 0
#on startup variables so they're global
var input_direction = Vector2(0, 0)
var x_vector = 0
var y_vector = 0
var is_moving = false

var last_x_vec = 0
var last_y_vec = 0

#turns on when the player is doing something like teleporting or shooting
var mid_action = false

var invincible = false

func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	x_vector = input_direction[0]
	y_vector = input_direction[1]
	
	#finds way player is currently facing 
	if x_vector != 0 or y_vector != 0:
		last_x_vec = x_vector
		last_y_vec = y_vector
	
	if x_vector > 0:
		animated_sprite.flip_h = false
		
	if x_vector < 0:
		animated_sprite.flip_h = true
	if Input.is_action_just_pressed("click"):
		shoot_fireball()
	if Input.is_action_just_pressed("rclick"):
		teleport()

func shoot_fireball():
	var marker = get_node("/root/Game/Marker2D")
	var FIREBALL = preload("res://scenes/fireball.tscn")
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

func on_hit():
	pass

#teleport logic
func teleport():
	invincible = true
	animated_sprite.play("default R")
	animated_sprite.play("disappear")
	print("start")
	

func _on_disappear_animation_finished():
	print("teleport")
	animated_sprite.play("reappear")
	position.x += last_x_vec * 300
	position.y += last_y_vec * 300




func _on_reappear_animation_finished():
	print("finished")
	invincible = false



func _physics_process(delta):
	timer += delta
	if invincible == false:
		get_input()
		move_and_slide()
		animation_tree()













