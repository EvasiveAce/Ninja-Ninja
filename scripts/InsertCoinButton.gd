extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _blink_label():
	$InsertCoinTimer.start(1.25)
	if $InsertCoinLabel.is_visible():
		$InsertCoinLabel.set_visible(false)
	else:
		$InsertCoinLabel.set_visible(true)
	yield($InsertCoinTimer, "timeout")


func _on_InsertCoinTimer_timeout():
	_blink_label()
