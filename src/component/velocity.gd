class_name VelocityComponent extends Node


@export_group("Movement")
@export var speed: float = 90.0
@export var accel: float = 900.0

var velocity := Vector2.ZERO


func accelerate(direction, delta) -> Vector2:
	velocity = velocity.move_toward(speed * direction, accel * delta)
	return velocity


func move(direction) -> Vector2:
	velocity = speed * direction
	return velocity
