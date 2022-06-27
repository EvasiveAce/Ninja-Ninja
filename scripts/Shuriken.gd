extends Area2D

const speed = 110
var velocity = Vector2()
var directionVel
var shurikenDamage = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$ShurikenAnimatedSprite.play("Thrown")

func _physics_process(delta):
	velocity.x = speed * delta * directionVel
	translate(velocity)

func _shuriken_instanciation(reality, direction):
	directionVel = direction
	if direction == -1:
		$ShurikenAnimatedSprite.flip_h = true

func _on_ShurikenVisibilityNotifier_screen_exited():
	queue_free()

func _on_Shuriken_body_entered(body):
	if body.is_in_group("Enemy"):
		body._shurikenHit(shurikenDamage)
		queue_free()
