extends Area2D

var direction := Vector2(0, -1)
var projectile_speed := 1000

func _process(delta: float) -> void:
	self.position += direction * projectile_speed * delta
