class_name WeaponComponent extends Node

signal weapon_ready(weapon: Weapon)
signal weapon_fired(weapon: Weapon)
signal weapon_empty(weapon: Weapon)

@export var weapon: Weapon
@export var foo: Shape2D

func _ready():
	weapon_ready.emit(weapon)
	weapon_empty.emit(weapon)

func _input(event: InputEvent) -> void:
	if weapon && event.is_action_pressed("fire"):
		weapon.fire(self.get_parent(), Vector2.RIGHT, func(): print("Fire weapon cb"))
		if weapon.fire(self.get_parent(), Vector2.LEFT): weapon_fired.emit(weapon)
	else: if event.is_action_released("fire"):
		print("What about charging?")
