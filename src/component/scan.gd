class_name ScanComponent extends Node2D

signal threat_detected(direction: Vector2)

@export var scanning := false:
	set(value):
		scanning = value
		player_ray_detect.enabled = scanning
		player_area_detect.monitoring = scanning
@export var scan_increment := PI * 0.5

@onready var player_ray_detect: RayCast2D = $RayCast2D
@onready var player_area_detect: Area2D = $Area2D

#var player: Player

func _ready() -> void:
	scanning = false

func _on_timer_timeout() -> void:
	if scanning:
		if player_ray_detect.is_colliding(): threat_detected.emit(Vector2.RIGHT.rotated(player_ray_detect.rotation))
		else: player_ray_detect.rotation += scan_increment

func _on_area_2d_body_entered(body: Node2D) -> void:
	pass
	#if scanning && player == body: threat_detected.emit(Vector2.ZERO)
