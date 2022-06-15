extends Node2D


const imageTexture = preload("res://tres/tileSet.tres")

const nBackgroundSky = preload("res://sprites/scenes/NormalBackgroundSky.png")
const nBackgroundMountains = preload("res://sprites/scenes/NormalBackgroundMountains.png")
const nBackgroundTrees = preload("res://sprites/scenes/NormalBackgroundTrees.png")

const tBackgroundSky = preload("res://sprites/scenes/TaintedBackgroundSky.png")
const tBackgroundMountains = preload("res://sprites/scenes/TaintedBackgroundMountains.png")
const tBackgroundTrees = preload("res://sprites/scenes/TaintedBackgroundTrees.png")

const nNinja = preload("res://sprites/characters/mainNinjaSpritesheet.png")
const tNinja = preload("res://sprites/characters/taintedNinjaSpritesheet.png")


# Called when the node enters the scene tree for the first time.
func _ready():
	_removeInput()
	$StartButton.grab_focus()
	$Player.visible = false
	$Player.position = Vector2(239, 168)

func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		_world_shift()

func _world_shift():
	if imageTexture.current_frame == 0:
		imageTexture.set_current_frame(1)
		$BackgroundSprites/BackgroundSky.texture = tBackgroundSky
		$BackgroundSprites/BackgroundMountains.texture = tBackgroundMountains
		$BackgroundSprites/BackgroundTrees.texture = tBackgroundTrees
		$Player.playerTexture = tNinja
		get_tree().call_group("Enemy", "_worldShift")
	elif imageTexture.current_frame == 1:
		imageTexture.set_current_frame(0)
		$BackgroundSprites/BackgroundSky.texture = nBackgroundSky
		$BackgroundSprites/BackgroundMountains.texture = nBackgroundMountains
		$BackgroundSprites/BackgroundTrees.texture = nBackgroundTrees
		$Player.playerTexture = nNinja
		get_tree().call_group("Enemy", "_worldShift")

func _on_Start_pressed():
	InputMap.load_from_globals()
	$Player.visible = true
	$StartButton.visible = false
	$Player.throwEnabled = true

func _removeInput():
	var index = 0
	var all_actions = InputMap.get_actions()
	for i in all_actions:
		if i == "ui_accept" or i == "ui_cancel":
			all_actions.remove(index)
		index += 1
	for d in all_actions:
		InputMap.action_erase_events(d)
