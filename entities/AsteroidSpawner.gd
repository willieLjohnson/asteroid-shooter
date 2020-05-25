extends Node

var asteroid_scene = load("res://objects/Asteroid.tscn")

var asteroid_spawn_interval := 2.0
var difficulty_index := 1.5

func _ready() -> void:
	_spawn_asteroid()
	
func _spawn_asteroid() -> void:
	var asteroid = asteroid_scene.instance()
	
	_set_asteroid_scale(asteroid)
	_set_asteroid_position(asteroid)
	_set_asteroid_trajectory(asteroid)
	
	add_child(asteroid)

func _set_asteroid_position(asteroid: RigidBody2D) -> void:
	var rect = get_viewport().size
	asteroid.position = Vector2(rand_range(0, rect.x), -100)

func _set_asteroid_trajectory(asteroid: RigidBody2D) -> void:
	asteroid.angular_velocity = rand_range(-4, 4)
	asteroid.angular_damp = 0
	asteroid.linear_velocity = Vector2(rand_range(-300 , 300), 300 + (difficulty_index * 10))
	asteroid.linear_damp = 0
	
func _set_asteroid_scale(asteroid: RigidBody2D) -> void:
	var randscale = rand_range(1, 3.5)
	asteroid.get_node("Sprite").scale = Vector2(randscale, randscale)
	asteroid.get_node("CollisionShape2D").scale = Vector2(randscale, randscale)
	
func _on_SpawnTimer_timeout() -> void:
	_spawn_asteroid()


func _on_DifficultyTimer_timeout() -> void:
	$SpawnTimer.wait_time = float(2.0) / float(difficulty_index)
	difficulty_index += 1
	print($SpawnTimer.wait_time)
	
func restart():
	$SpawnTimer.stop()
	$DifficultyTimer.stop()
	asteroid_spawn_interval = 2
	difficulty_index = 1.5
	$SpawnTimer.start()
	$DifficultyTimer.start()
