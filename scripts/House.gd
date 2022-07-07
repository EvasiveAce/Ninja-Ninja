extends Area2D


var max_health
var currentHealth

onready var healthbar = $HouseHPBar

# Called when the node enters the scene tree for the first time.
func _ready():
	max_health = 10
	currentHealth = max_health
	healthbar.hide()
	healthbar.max_value = max_health


func _update_healthbar(value):
	currentHealth = currentHealth - value
	if value < healthbar.max_value:
		healthbar.show()
	healthbar.value = currentHealth
