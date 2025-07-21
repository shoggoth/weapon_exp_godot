class_name RangedWeapon extends Weapon

@export var bullet: PackedScene

func fire(from_node: Node2D, direction: Vector2 = Vector2.ZERO, completion: Callable = Global.null_callable) -> bool:
	var b := bullet.instantiate()
	from_node.add_child(b)
	b.go(Vector2.RIGHT * 100)
	return true
