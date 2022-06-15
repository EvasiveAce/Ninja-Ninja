extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var animationStart = true
# Called when the node enters the scene tree for the first time.
func _ready():
	$InsertCoinButton.grab_focus()
	_removeInput()
	$OutputCapture.connect("cutscene_finished", self, "_cutscene_finished")


func _process(delta):
	if animationStart:
		_animation_Play()


func _on_InsertCoinButton_pressed():
	$OutputCapture._reset()
	get_tree().change_scene("res://scenes/mainScenes/MainArcade.tscn")

func _animation_Play():
	animationStart = false
	$AnimationPlayer.play("InsertCoinBlink")
	yield(get_tree().create_timer(10),"timeout")
	$AnimationPlayer.play("InsertCoinAnimation")
	yield($AnimationPlayer,"animation_finished")
	$OutputCapture.ready = true
	yield($OutputCapture, "cutscene_finished")
	$AnimationPlayer.play("InsertCoinAnimationOutro")
	yield($OutputCapture, "cutscene_finished")

func _removeInput():
	var index = 0
	var all_actions = InputMap.get_actions()
	for i in all_actions:
		if i == "ui_accept" or i == "ui_cancel":
			all_actions.remove(index)
		index += 1
	for d in all_actions:
		InputMap.action_erase_events(d)
