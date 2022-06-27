extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 25
const ACCELERATION = 5
const MAX_SPEED = 100
const JUMP_HEIGHT = -350

var throwEnabled = false

var playerTexture
var playerTextureDefault = preload("res://sprites/characters/mainNinjaSpritesheet.png")
var shurikenProjectile = preload("res://scenes/Shuriken.tscn")

var motion = Vector2()
var state_machine

signal throwEnable

func _ready():
	state_machine = $PlayerAnimationTree.get("parameters/playback")
	playerTexture = playerTextureDefault

func _physics_process(delta):
	_movement()
	$PlayerSprite.texture = playerTexture
	if Input.is_action_just_pressed("ui_accept") and throwEnabled:
			_throw()
			throwEnabled = false
			yield(get_tree().create_timer(.5), "timeout")
			throwEnabled = true

func _throw():
	var shuriken = shurikenProjectile.instance()
	shuriken.position = $PlayerThrowPosition.global_position
	if playerTexture == playerTextureDefault:
		shuriken._shuriken_instanciation(0, sign($PlayerThrowPosition.position.x))
	else:
		shuriken._shuriken_instanciation(1, sign($PlayerThrowPosition.position.x))
	get_parent().get_node("ShurikenContainer").add_child(shuriken)

func _movement():
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$PlayerSprite.flip_h = false
		$PlayerThrowPosition.position = Vector2(11,1)
		state_machine.travel("Run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$PlayerSprite.flip_h = true
		$PlayerThrowPosition.position = Vector2(-11,1)
		state_machine.travel("Run")
	else:
		state_machine.travel("Idle")
		friction = true
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_select"):
			motion.y = JUMP_HEIGHT
		#More slippery
		#if friction:
			#motion.x = lerp(motion.x, 0, 0.2)
	else:
		if motion.y < 0:
			state_machine.travel("Jump")
		else:
			state_machine.travel("Fall")
		if friction:
			motion.x = lerp(motion.x, 0, 0.05)
	
	motion = move_and_slide(motion, UP)

