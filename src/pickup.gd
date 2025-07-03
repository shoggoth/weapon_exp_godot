class_name Pickup extends Area2D

signal picked_up(pickup: Pickup)

enum PickupType { LANTERN }

var type: PickupType
var score_value: int
var score_showing: bool:
	get: return $Score.visible

func _ready():
	$Score.text = str(score_value)

func display_score_label():
	$Sprite2D.hide()
	$Score.show()
	$Score/Timer.start()

func _on_body_entered(_body):
	display_score_label()
	picked_up.emit(self)

func _on_timer_timeout():
	queue_free()
