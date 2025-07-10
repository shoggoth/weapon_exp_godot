class_name WeaponComponent extends Node

@export var current_weapon: Weapon

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire"):
		print("Fire button pressed")
		if current_weapon:
			print("Fire weapon: " + str(current_weapon))
			current_weapon.fire(self.get_parent(), Vector2.RIGHT, func(): print("Fire weapon cb"))
	else: if event.is_action_released("fire"):
		print("Fire button released")


func _on_weapon_weapon_ready(from: Weapon) -> void:
	print("Weapon " + str(from) + " is ready")

func _on_weapon_weapon_empty(from: Weapon) -> void:
	print("Weapon " + str(from) + " is empty")

func _on_weapon_weapon_fired(from: Weapon) -> void:
	print("Weapon " + str(from) + " was fired")
