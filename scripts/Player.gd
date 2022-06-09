extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 25
const  ACCELERATION = 5
const  MAX_SPEED = 100
const  JUMP_HEIGHT = -350

var playerTexture = preload("res://sprites/characters/mainNinjaSpritesheet.png")

var motion = Vector2()

var state_machine

func _ready():
	state_machine = $PlayerAnimationTree.get("parameters/playback")

func _physics_process(delta):
	_movement()
	$PlayerSprite.texture = playerTexture


func _movement():
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$PlayerSprite.flip_h = false
		state_machine.travel("Run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$PlayerSprite.flip_h = true
		state_machine.travel("Run")
	else:
		state_machine.travel("Idle")
		friction = true
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			motion.y = JUMP_HEIGHT
		if friction:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if motion.y < 0:
			state_machine.travel("Jump")
		else:
			state_machine.travel("Fall")
		if friction:
			motion.x = lerp(motion.x, 0, 0.05)
	
	motion = move_and_slide(motion, UP)
