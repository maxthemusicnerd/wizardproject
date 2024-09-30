extends CharacterBody2D


const SPEED = 3

func _ready():
	pass

func _physics_process(delta):
	var player = get_node("/root/Game/Player")
	var p_pos = player.global_position
	var xdif = p_pos[0] - position[0]
	var ydif = p_pos[1] - position[1]
	var mvdist = SPEED / (abs(xdif) + abs(ydif))
	position[0] += mvdist * xdif
	position[1] += mvdist * ydif
	#var direction = 400
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
	#move_and_slide()


func _on_area_2d_area_entered(area):
	var game_node = get_parent()
	var player = game_node.get_node("Player")
	if area.is_in_group("fireball"):
		player.kill_counter += 1 
		self.queue_free()
	pass # Replace with function body.
