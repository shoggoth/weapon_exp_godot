class_name Weapon extends Node

signal weapon_ready(from: Weapon)
signal weapon_fired(from: Weapon)
signal weapon_empty(from: Weapon)

@export_group("Properties")
@export var bullet_scene: PackedScene
@export var bullet_range: float = 200
@export var radius: float = 0
@export var bullet_offset: Vector2
@export var pool_size: int = 0
@export_group("Control")
@export var quantise_direction: bool = false

func _ready():
	weapon_ready.emit(self)
	weapon_empty.emit(self)

func fire(from_node: Node2D, direction: Vector2 = Vector2.ZERO, completion: Callable = Global.null_callable):
	print("Fire from ", from_node, " direction ", direction)
	Ranged.new().fire(from_node, direction)
	weapon_fired.emit(self)
	if completion != Global.null_callable: completion.call()

class Ranged:
	func fire(from_node: Node2D, direction: Vector2 = Vector2.ZERO):
		print("Ranged Fire from ", from_node, " direction ", direction)
