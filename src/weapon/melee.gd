class_name MeleeWeapon extends Weapon

enum AttackType { THRUST, SLASH, BASH, THROW, SHOOT }

@export var attack_type: AttackType

func fire(from_node: Node2D, direction: Vector2 = Vector2.ZERO, completion: Callable = Global.null_callable) -> bool:
	match attack_type:
		AttackType.THRUST:
			Melee.new("foo 1").thrust()
		AttackType.SLASH:
			Melee.new("foo 2").slash()
		AttackType.BASH:
			Melee.new("foo 3").bash()
		[AttackType.THROW, AttackType.SHOOT]:
			Ranged.new().fire(from_node, direction)
	
	Ranged.new().fire(from_node, direction)
	return true

class Foobar extends Weapon.Melee:
	
	var foo: int
