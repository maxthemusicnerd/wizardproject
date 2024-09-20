extends CharacterBody2D

@export var speed = 500

@onready var animated_sprite = $AnimatedSprite2D

var dog = "hello"

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	velocity = input_direction * speed
	
	var is_moving = false
	
	var x_vector = input_direction[0]
	var y_vector = input_direction[1]
	
	if x_vector == 0 and y_vector == 0:
		animated_sprite.play("default R")
		is_moving = false
	
	else:
		animated_sprite.play("run R")
		is_moving = true
	
	
	if x_vector > 0:
		animated_sprite.flip_h = false
		
	if x_vector < 0:
		animated_sprite.flip_h = true
	var marker = get_node("/root/Game/Marker2D")
	var FIREBALL = preload("res://scenes/fireball.tscn")
	if Input.is_action_just_pressed("click") and is_moving == true:
		var b = FIREBALL.instantiate()
		owner.add_child(b)
		var marker_pos = marker.global_position
		b.global_position = marker_pos
		

func _physics_process(delta):
	get_input()
	move_and_slide()
