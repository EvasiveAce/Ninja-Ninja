extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _spawnInit():
	var modulateInt = rng.randi_range(0, 1)
	if modulateInt == 0:
		modulate = Color(1,1,1,.5)
	else:
		modulate = Color(1,1,1,1)
	var sideInt = rng.randi_range(0, 1)
	if sideInt == 0:
		position = Vector2(rng.randf_range(70, 107), 171)
	else:
		position = Vector2(rng.randf_range(375, 411), 171)

func _worldShift():
	if modulate == Color(1,1,1,1):
		modulate = Color(1,1,1,.5)
	else:
		modulate = Color(1,1,1,1)
