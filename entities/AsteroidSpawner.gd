extends Node

var asteroid_scene = load("res://objects/Asteroid.tscn")

func _ready() -> void:
	_spawn_asteroid()
	
func _spawn_asteroid() -> void:
	var asteroid = asteroid_scene.instance()
	
	_set_asteroid_position(asteroid)
	_set_asteroid_trajectory(asteroid)
	
	add_child(asteroid)

func _set_asteroid_position(asteroid: RigidBody2D) -> void:
	var rect = get_viewport().size
	asteroid.position = Vector2(rand_range(0, rect.x), -100)

func _set_asteroid_trajectory(asteroid: RigidBody2D) -> void:
	asteroid.angular_velocity = rand_range(-4, 4)
	asteroid.angular_damp = 0
	asteroid.linear_velocity = Vector2(rand_range(-300, 300), 300)
	asteroid.linear_damp = 0
	
func _on_SpawnTimer_timeout() -> void:
	_spawn_asteroid()
