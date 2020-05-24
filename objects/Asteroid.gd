extends RigidBody2D

signal explode

var asteroid_small_scene := load("res://objects/AsteroidSmall.tscn")
var rand_num_generator := RandomNumberGenerator.new()

var is_exploded := false

func _ready() -> void:
	var main_camera = get_node("/root/Game/MainCamera")
	self.connect("explode", main_camera, "asteroid_exploded")

func explode() -> void:
	if is_exploded:
		return
		
	is_exploded = true
	
	emit_signal("explode")
	
	_spawn_asteroid_smalls(4) 
	
	get_parent().remove_child(self)
	queue_free()

func _spawn_asteroid_smalls(num: int) -> void:
	for i in range (num):
		_spawn_asteroid_small()
	
func _spawn_asteroid_small() -> void:
	var asteroid_small = asteroid_small_scene.instance()
	asteroid_small.position = self.position
	_randomize_trajectory(asteroid_small)
	get_parent().add_child(asteroid_small)
	
func _randomize_trajectory(asteroid) -> void:
	asteroid.angular_velocity = rand_range(-4, 4)
	asteroid.angular_damp = 0
	
	rand_num_generator.randomize()
	var linear_vel_x = rand_num_generator.randi_range(-1, 1)
	var linear_vel_y = rand_num_generator.randi_range(-1, 1)
	
	asteroid.linear_velocity = Vector2(linear_vel_x * 400, linear_vel_y * 400)
	asteroid.linear_damp = 0

func _on_VisibilityNotifier2D_viewport_exited(viewport: Viewport) -> void:
	queue_free()
