class_name WeaponComponent extends Node

signal weapon_ready(weapon: Weapon)
signal weapon_fired(weapon: Weapon)
signal weapon_empty(weapon: Weapon)

@export var weapon: Weapon
@export var foo: Shape2D
@export var fire_on_input := true

func _ready():
	weapon_ready.emit(weapon)
	weapon_empty.emit(weapon)

func _physics_process(delta: float) -> void:
	if fire_on_input: return
	else: if weapon && Input.is_action_just_pressed("fire"):
		if weapon.fire(self.get_parent(), Vector2.LEFT): weapon_fired.emit(weapon)

func _input(event: InputEvent) -> void:
	if fire_on_input && weapon && event.is_action_pressed("fire"):
		weapon.fire(self.get_parent(), Vector2.RIGHT, func(): print("Fire weapon cb"))
		if weapon.fire(self.get_parent(), Vector2.LEFT): weapon_fired.emit(weapon)
	else: if event.is_action_released("fire"):
		print("What about charging?")
