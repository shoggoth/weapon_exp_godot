extends HitBox

@export var speed_multiplier: float = 1.0
@export var duration: float = 1.0

var direction: Vector2

func _ready():
	go(direction)

func go(direction: Vector2) -> bool:
	var move_tween = create_tween()
	move_tween.tween_property(self, "position", direction * speed_multiplier, duration).as_relative()
	move_tween.tween_callback(func(): queue_free())
	if direction.y: rotation = PI * 0.5
	if !get_meta("mute", false): $Fire.play()
	return true
	
func _on_body_entered(body):
	if !(body is TileMapLayer): push_error("Bullet detected spurious body collision")
	queue_free()
