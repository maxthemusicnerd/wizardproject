extends Marker2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
var enemy = preload("res://scenes/NEWENEMY.tscn")
var time_passed = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_passed += delta
	if time_passed >= 1:
		var b = enemy.instantiate()
		owner.add_child(b)
		position.x = randi() % 1000
		position.y = randi() % 1000
		b.position = position
		time_passed = 0

