extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.a


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#const MOVEDIST = 5
	#var player = get_node("/root/Game/Player")
	#var p_pos = player.global_position
	#var xdif = p_pos[0] - position[0]
	#var ydiif 
	
	
	pass


func _on_area_entered(area):
	if area.is_in_group("fireball"):
		self.queue_free()
