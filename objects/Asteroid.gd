extends RigidBody2D

signal explode

var explosion_particles_scene := load("res://objects/ParticlesAsteroidExplosion.tscn")
var asteroid_small_scene := load("res://objects/AsteroidSmall.tscn")
var rand_num_generator := RandomNumberGenerator.new()

var explosion_pitch = 1

var is_exploded := false

signal score_changed
var score_value = 100
var points_scored_scene = load("res://ui/PointsScored.tscn")

func _ready() -> void:
	var main_camera = get_node("/root/Game/MainCamera")
	self.connect("explode", main_camera, "asteroid_exploded")
	var label = get_tree().get_root().get_node("Game/GUI/MarginContainer/HBoxContainer/VBoxContainer/Score")
	self.connect("score_changed", label, "update_score")

func explode() -> void:
	if is_exploded:
		return
		
	is_exploded = true
	
	_explosion_particles()
	_play_explosion_sound()
	
	emit_signal("explode")
	
	emit_signal("score_changed", score_value)
	_spawn_score()
	
	
	_spawn_asteroid_smalls(4) 
	
	get_parent().remove_child(self)
	queue_free()
	
func _spawn_score():
	var points_scored = points_scored_scene.instance()
	points_scored.get_node("Label").text = str(score_value)
	points_scored.position = self.position
	
	get_parent().add_child(points_scored)
	
func _play_explosion_sound() -> void:
	var explosion_sound = AudioStreamPlayer2D.new()
	explosion_sound.stream = load("res://assets/audio/sfx/AsteroidExplosion.wav")
	explosion_sound.pitch_scale = explosion_pitch
	explosion_sound.position = self.position
	get_parent().add_child(explosion_sound)
	explosion_sound.play(0)
	
func _explosion_particles() -> void:
	var explosion_particles = explosion_particles_scene.instance()
	explosion_particles.position = self.position
	get_parent().add_child(explosion_particles)
	explosion_particles.emitting = true


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
