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
	pass # Replace with function body.


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
	elif imageTexture.current_frame == 1:
		imageTexture.set_current_frame(0)
		$BackgroundSprites/BackgroundSky.texture = nBackgroundSky
		$BackgroundSprites/BackgroundMountains.texture = nBackgroundMountains
		$BackgroundSprites/BackgroundTrees.texture = nBackgroundTrees
		$Player.playerTexture = nNinja
