extends Marker2D

var dog = Vector2(0, 0)



func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var game_node = get_parent()
	var player = game_node.get_node("Player")
	var xvec = player.last_x_vec
	var yvec = player.last_y_vec
	dog = Vector2(xvec, yvec)
	#gets player node and turns it into a variable. It is in the function so that it can be accessed locally
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
	


