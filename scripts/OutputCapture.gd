extends Node2D

var direction
var timeArray
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var iterator = 0
var ready = false

signal cutscene_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_node("Player").position = Vector2(100, 127)
	direction = Array(_load('res://dats/walk.txt').split(","))
	timeArray = Array(_load('res://dats/walkTime.txt').split(","))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if iterator <= direction.size() and ready:
		_movement(direction[iterator - 1], float(timeArray[iterator - 1]))
		iterator += 1
		if iterator == direction.size() + 1:
			ready = false
			emit_signal("cutscene_finished")

func _load(fileLoc):
	var file = File.new()
	file.open(fileLoc, file.READ)
	var content = file.get_as_text()
	file.close()
	return content

func _movement(key, time):
	if key == "RELEASED":
		ready = false
		yield(get_tree().create_timer(time), "timeout")
		ready = true
	else:
		ready = false
		Input.action_press(key)
		yield(get_tree().create_timer(time), "timeout")
		Input.action_release(key)
		ready = true

func _cutscene_finished():
	_reset()
	
func _reset():
	get_parent().get_node("Player").position = Vector2(100, 127)
	ready = false
