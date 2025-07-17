class_name RangedWeapon extends Weapon

@export var bullet: PackedScene

func fire(from_node: Node2D, direction: Vector2 = Vector2.ZERO, completion: Callable = Global.null_callable) -> bool:
	from_node.add_child(bullet.instantiate())
	return true
