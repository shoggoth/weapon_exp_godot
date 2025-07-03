extends Node

var d_pad = Vector2.ZERO
var fire = false
var bomb = false

func _physics_process(_delta):
	fire =  Input.is_action_pressed("fire")
	bomb =  Input.is_action_just_pressed("bomb")
	d_pad = Input.get_vector("left", "right", "up", "down")
