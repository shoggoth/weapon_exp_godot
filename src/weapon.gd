@tool class_name Weapon extends Resource

enum AttackType { THRUST, SLASH, BASH, THROW, SHOOT }

@export_group("Properties")
@export var weapon_name: String
@export var attack_type: AttackType
@export var scene: PackedScene
@export var radius: float = 0
@export var offset: Vector2
@export_group("Control")
@export var quantise_direction: bool = false
@export_category("Experimental")
@export var ranged: bool

func fire(from_node: Node2D, direction: Vector2 = Vector2.ZERO, completion: Callable = Global.null_callable) -> bool:
	print("Fire from ", from_node, " direction ", direction)
	match attack_type:
		AttackType.THRUST:
			Melee.new().thrust()
		AttackType.SLASH:
			Melee.new().slash()
		AttackType.BASH:
			Melee.new().bash()
		[AttackType.THROW, AttackType.SHOOT]:
			Ranged.new().fire(from_node, direction)
			
	Ranged.new().fire(from_node, direction)
	if completion.is_valid(): completion.call()
	return true

func setup():
	print("Setting up")

class Melee:
	func thrust():
		print("Thrust!!11!!")

	func slash():
		print("Slash!!11!!")

	func bash():
		print("Bosh-a!!11!!")

class Ranged:
	@export_group("Properties")
	@export var weapon_name: String
	@export var bullet_scene: PackedScene
	@export var bullet_range: float = 200
	@export var radius: float = 0
	@export var bullet_offset: Vector2
	@export var pool_size: int = 0
	@export_group("Control")
	@export var quantise_direction: bool = false
	
	func fire(from_node: Node2D, direction: Vector2 = Vector2.ZERO):
		print("Ranged Fire from ", from_node, " direction ", direction)
	
	func string_interp_reminder() -> String:
		if (weapon_name == ""):
			return "%f %f" % [radius, bullet_range]
		return "%s %d %s" % [weapon_name, pool_size, bullet_offset]
