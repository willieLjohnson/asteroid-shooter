extends Sprite

func _ready() -> void:
	self.rotation = rand_range(-180, 180)
	self.scale = Vector2(2, 2)

func _on_Timer_timeout() -> void:
	queue_free()
