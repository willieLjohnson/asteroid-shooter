extends Node

var asteroid_scene = load("res://objects/Asteroid.tscn")

func _ready() -> void:
	_spawn_asteroid()
	
func _spawn_asteroid() -> void:
	var asteroid = asteroid_scene.instance()
	
	asteroid.position = Vector2(50, 0)
	
	add_child(asteroid)
