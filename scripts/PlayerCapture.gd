extends Node2D


var positionArray = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if get_parent().position.x <= 416:
		positionArray += str(get_parent().position)
		positionArray += "."
	else:
		get_parent().get_parent().get_node("InputCapture")._save(positionArray, "res://dats/walkPlayerPos.txt")
