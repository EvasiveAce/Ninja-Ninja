extends Area2D

const speed = 110
var velocity = Vector2()
var directionVel

# Called when the node enters the scene tree for the first time.
func _ready():
	$ShurikenAnimatedSprite.play("Thrown")



func _physics_process(delta):
	velocity.x = speed * delta * directionVel
	translate(velocity)

func _shuriken_instanciation(reality, direction):
	directionVel = direction
	if reality == 0:
		set_collision_layer(2)
		set_collision_mask(2)
	elif reality == 1:
		set_collision_layer(4)
		set_collision_mask(4)
	
	if direction == -1:
		$ShurikenAnimatedSprite.flip_h = true

func _on_ShurikenVisibilityNotifier_screen_exited():
	queue_free()
