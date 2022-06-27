extends KinematicBody2D


var max_health

onready var healthbar = $HouseHPBar

# Called when the node enters the scene tree for the first time.
func _ready():
	max_health = 10
	healthbar.hide()
	if get_parent() and get_parent().get("max_health"):
		healthbar.max_value = get_parent().max_health


func _update_healthbar(value):
	if value < healthbar.max_value:
		show()
	healthbar.value = value
