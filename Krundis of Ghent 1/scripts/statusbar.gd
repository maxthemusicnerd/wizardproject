extends CanvasLayer

@onready var health_anim = $AnimatedSprite2D
var game_node = get_parent()
var player


func _ready():
	var game_node = get_parent()
	player = game_node.get_node("Player")
	pass # Replace with function body.


func hp_manager():
	if player.health == 5:
		health_anim.play("full")
	elif player.health == 4:
		health_anim.play("four")
	elif player.health == 3:
		health_anim.play("three")
	elif player.health == 2:
		health_anim.play("two")
	elif player.health == 1:
		health_anim.play("one")
	else:
		health_anim.play("empty")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	hp_manager()
