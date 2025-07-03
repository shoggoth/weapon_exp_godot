class_name WeaponComponent extends Node

signal weapon_fired(source_node: Node2D, direction: Vector2)
signal weapon_ready

@export_group("Properties")
@export var bullet_scene: PackedScene
@export var bullet_range: float = 200
@export var radius: float = 0
@export var bullet_offset: Vector2
@export var pool_size: int = 0
@export_group("Control")
@export var quantise_direction: bool = false

var can_fire := true
var _pool: Array[Node2D]

func _ready():
	for _t in pool_size:
		_pool.append(bullet_scene.instantiate())

func fire(source_node: Node2D, direction: Vector2) -> bool:
	if !can_fire: return false
	can_fire = false
	$Timer.start()
	var b: HitBox = bullet_scene.instantiate()
	#if quantise_direction: direction = Global.quantise(direction)
	b.direction = direction * bullet_range
	b.position = source_node.position + bullet_offset + direction * radius
	b.collision_layer = (source_node.collision_layer & 3) | 16
	add_child(b)
	weapon_fired.emit(source_node, direction)
	return true

func _on_timer_timeout():
	can_fire = true
	weapon_ready.emit()
