extends Area2D

var direction := Vector2(0, -1)
var projectile_speed := 1000

func _process(delta: float) -> void:
	self.position += direction * projectile_speed * delta


func _on_VisibilityNotifier2D_viewport_exited(viewport: Viewport) -> void:
	queue_free()
 


func _on_Laser_body_shape_entered(body_id: int, body: Node, body_shape: int, area_shape: int) -> void:
		if (!self.is_queued_for_deletion() && body.is_in_group("asteroids")):
			body.call_deferred("explode")
			get_parent().remove_child(self)
			queue_free()
			
