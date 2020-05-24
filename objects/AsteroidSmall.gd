extends "res://objects/Asteroid.gd"

func _ready() -> void:
	var main_camera = get_node("/root/Game/MainCamera")
	self.connect("explode", main_camera, "asteroid_small_exploded")

func explode() -> void:
	if is_exploded:
		return
		
	is_exploded = true
	
	_explosion_particles()
	explosion_pitch = 1.2
	_play_explosion_sound()
	
	emit_signal("explode")
	
	get_parent().remove_child(self)
	queue_free()
