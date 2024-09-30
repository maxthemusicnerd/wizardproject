extends CharacterBody2D

@export var speed = 300

@onready var animated_sprite = $AnimatedSprite2D

@onready var ace = $ace
@onready var yes = $yes

func _ready():
	#instantiate marker reticle thingy and place it in front of the player
	var marker = preload("res://scenes/marker_2d.tscn")
	var marker_make = marker.instantiate()
	owner.add_child.call_deferred(marker_make)
	var marker_pos_x = position.x + 30
	marker_make.global_position = Vector2(marker_pos_x, position.y)


#on startup variables so they're global
var input_direction = Vector2(0, 0)
var x_vector = 0
var y_vector = 0
var is_moving = false

var current_animation = ""

#this is the last direction the player chose to face, as opposed to their current vector
var last_x_vec = 0
var last_y_vec = 0

#turns on when the player is doing something like teleporting or shooting
var mid_action = false

var invincible = false


#JOKE CODE DELETE
var kill_counter = 0


#gets input every frame (not really but its hard to explain)
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
	current_animation = "shoot_fire"



func animation_tree():
	if mid_action == false:
		if x_vector == 0 and y_vector == 0:
			animated_sprite.play("default R")
			is_moving = false
			speed = 300
		else:
			animated_sprite.play("run R")
			is_moving = true
			if speed < 310:
				speed += 0.2
			elif speed < 400:
				speed += 14


func _on_animated_sprite_2d_animation_finished():
	if current_animation == "shoot_fire":
		mid_action = false
		return 2
	if current_animation == "disappear":
		current_animation = "reappear"
		animated_sprite.play("reappear")
		position.x += last_x_vec * 500
		position.y += last_y_vec * 350
		return 2
	if current_animation == "reappear":
		invincible = false
		current_animation = "running"
		mid_action = false
		return 2

func teleport():
	invincible = true
	mid_action = true
	current_animation = "disappear"
	animated_sprite.play("disappear")






func on_hit():
	pass

#teleport logic






func _physics_process(delta):
	if kill_counter >= 5:
		yes.play()
		ace.play()
		kill_counter = 0
	if invincible == false:
		get_input()
		move_and_slide()
		animation_tree()






















func _on_ace_finished():
	pass
