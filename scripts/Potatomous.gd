extends KinematicBody2D

#_movement(): basics
const GRAVITY = 25
const ACCELERATION = 5
const MAX_SPEED = 20
const UP = Vector2(0, -1)
var motion = Vector2()
#_movement(): basics

#enemyBasics
var HP = 0
var flip = false
var movementEnabled = true
var damage = 1
#enemyBasics

# Called when the node enters the scene tree for the first time.
func _ready():
	HP = 1
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flip:
		$PotatomousSprite.flip_h = true
	elif flip == false:
		$PotatomousSprite.flip_h = false
	if movementEnabled:
		_movement()

func _worldShift():
	if modulate == Color(1,1,1,1):
		modulate = Color(1,1,1,.5)
		set_collision_mask(17)
	else:
		modulate = Color(1,1,1,1)
		set_collision_mask(25)

func _movement():
	motion.y += GRAVITY
	
	if $PotatomousSprite.flip_h == false:
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$PotatomousAnimationPlayer.play("Walk")
	elif $PotatomousSprite.flip_h:
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$PotatomousAnimationPlayer.play("Walk")
	motion = move_and_slide(motion, UP)

func _shurikenHit(dmg):
	HP -= dmg
	if HP <= 0:
		_death()

func _death():
	$PotatomousSprite.hide()
	movementEnabled = false
	$PotatomousAnimatedSprite.show()
	$PotatomousAnimatedSprite.play("Death")
	yield($PotatomousAnimatedSprite, "animation_finished")
	queue_free()

func _on_PotatomousArea_area_entered(area):
		if area.is_in_group("House"):
			area._update_healthbar(1)
			_death()
