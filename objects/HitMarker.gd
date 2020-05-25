extends Sprite

func _ready() -> void:
	self.rotation = rand_range(-180, 180)
	var randScale = float(randf() * 2.0 + 1)
	self.scale = Vector2(randScale, randScale)

func _on_Timer_timeout() -> void:
	queue_free()
