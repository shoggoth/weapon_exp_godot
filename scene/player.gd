class_name Player extends CharacterBody2D

func _on_weapon_component_weapon_fired(weapon: Weapon) -> void:
	print("%s fired %s" % [weapon, weapon.name])
