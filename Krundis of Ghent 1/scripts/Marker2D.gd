extends Marker2D


# Called when the node enters the scene tree for the first time.
@onready var playernode = get_node("res://scripts/Player.gd")
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#gets player node and turns it into a variable. It is in the function so that it can be accessed locally
	var player = get_node("/root/Game/Player")
	#collect player input every frame. It averages out into a vector. It makes a circle around 0,0
	var dog = Input.get_vector("left", "right", "up", "down")
	#these are the points on a grid that are being inputted into
	var angle_x = dog[0]
	var angle_y = dog[1]
	if player != null:
		var player_position = player.global_position
		var player_x = player_position[0]
		var player_y = player_position[1]
		if angle_x != 0 or angle_y != 0:
			#'position' is the position of the node of which's script we're inside. 
			# we take the position of the vector, multiply it by 30 or 25 to psuh it away from the player.
			#if the vector is negative it will be pushed in the other direction
			position[0] = (30 * angle_x) + player_x
			position[1] = (25 * angle_y) + player_y
	


