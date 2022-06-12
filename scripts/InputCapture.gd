extends Node2D


var bindingInt = 0
var arrayString = ""
var arrayStringTime = ""

var timeStamp = 0
var timeStampUnreleased = 0
var eventScancode = ""

var pressed = false
var released = false

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		bindingInt += 1
	if bindingInt == 2:
		_save(arrayString, 'res://dats/walk.txt')
		_save(arrayStringTime, 'res://dats/walkTime.txt')
	if pressed:
		timeStamp += delta
	if released:
		timeStampUnreleased += delta

func _input(event):
	if event is InputEventKey and event.pressed and bindingInt == 1:
		eventScancode = OS.get_scancode_string(event.scancode)
		pressed = true
		released = false
	if event is InputEventKey and not event.pressed and bindingInt == 1:
		pressed = false
		released = true
		arrayString += _convert(eventScancode)
		arrayString += ","
		arrayStringTime += str(timeStamp)
		arrayStringTime += ","
		timeStamp = 0
		if timeStampUnreleased > 0:
			arrayString += "RELEASED"
			arrayString += ","
			arrayStringTime += str(timeStampUnreleased)
			arrayStringTime += ","
			timeStampUnreleased = 0


func _save(data, fileLink):
	var file = File.new()
	file.open(fileLink, File.WRITE)
	file.store_string(data)
	file.close()

func _convert(key):
	if key == "Right":
		return "ui_right"
	elif key == "Left":
		return "ui_left"
	elif key == "Space":
		return "ui_select"
	elif key == "Enter":
		return "ui_accept"
	elif key == "Up":
		return "ui_up"
	elif key == "Down":
		return "ui_down"
	else:
		return ""
