extends Node

var asteroid_scene = load("res://objects/Asteroid.tscn")

func _ready() -> void:
	_spawn_asteroid()
	
func _spawn_asteroid() -> void:
	var asteroid = asteroid_scene.instance()
	
	_set_asteroid_position(asteroid)
	
	add_child(asteroid)

func _set_asteroid_position(asteroid) -> void:
	var rect = get_viewport().size
	asteroid.position = Vector2(rand_range(0, rect.x), -100)

func _on_SpawnTimer_timeout() -> void:
	_spawn_asteroid()
