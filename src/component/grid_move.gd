class_name MoveComponent extends Node

signal finished_moving(move_component: MoveComponent)

@export_group("Movement")
@export var speed: float = 0.7
#@export var grid_size := Global.GRID_SIZE
@export_group("Control")
@export var quantise_direction: bool = false
@export var normalise_direction: bool = false
@export_group("Grid Limits")
@export var minimum := Vector2(0, 0)
@export var maximum := Vector2(7, 6)

var _move_tween: Tween = null

func move(node: Node2D, direction: Vector2) -> bool:
	if _move_tween: return false
	#if quantise_direction: direction = Global.quantise(direction)
	if normalise_direction: direction = direction.normalized()
	var m = grid_position(node.position) + direction
	if !is_in_grid_limits(m): return false
	_move_tween = create_tween()
	#_move_tween.tween_property(node, "position", m * grid_size, speed)
	_move_tween.tween_callback(stop)
	return true

func track(node: Node2D, destination: Vector2, prioritise_x: bool = false) -> bool:
	if _move_tween || !is_in_grid_limits(destination): return false
	var m = destination - grid_position(node.position)
	_move_tween = create_tween()
	while m.length() >= 1:
		var vec = _prioritise(m, prioritise_x)
		#_move_tween.tween_property(node, "position", vec * grid_size, speed).as_relative()
		m -= vec
	_move_tween.tween_callback(stop)
	return true

func stop():
	if _move_tween:
		_move_tween.kill()
		_move_tween = null
		finished_moving.emit(self)

func grid_position(pos: Vector2) -> Vector2:
	return pos

func is_in_grid_limits(pos: Vector2) -> bool:
	return Rect2(minimum, maximum).has_point(pos)

func _prioritise(vec: Vector2, prioritise_x: bool) -> Vector2:
	if prioritise_x && abs(vec.x) > 0: vec.y = 0
	elif abs(vec.y) > 0: vec.x = 0
	return vec.normalized()
