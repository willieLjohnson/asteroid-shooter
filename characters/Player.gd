extends KinematicBody2D

const SPEED := 600

signal laser_shoot
signal player_died

var player_explosion_scene = load("res://objects/ParticlesPlayerExplosion.tscn")

func _ready() -> void:
	var camera = get_parent().get_node("MainCamera")
	self.connect("laser_shoot", camera, "_on_Player_laser_shoot")
	
	var game = get_parent()
	self.connect("player_died", game, "_on_Player_player_died")

func _physics_process(delta: float) -> void:
	var velocity := Vector2()
	
	if (Input.is_action_pressed("ui_left")):
		velocity.x = -SPEED
		rotation = -0.5
	elif (Input.is_action_pressed("ui_right")):
		velocity.x = SPEED
		rotation = 0.5
	else:
		rotation = 0.0
		
	if (Input.is_action_pressed("ui_up")):
		velocity.y = -SPEED
	if (Input.is_action_pressed("ui_down")):
		velocity.y = SPEED
	
	move_and_collide(velocity * delta)
	if position.y > 720:
		position.y = 720
	if position.y < 0:
		position.y = 0

func _unhandled_key_input(event: InputEventKey) -> void:
	if (event.is_action_pressed("shoot")):
		$LaserWeapon.shoot()
		emit_signal("laser_shoot")


func _on_Hitbox_body_entered(body: Node) -> void:
	if (!self.is_queued_for_deletion() && body.is_in_group("asteroids")):
		explode()
		
func explode() -> void:
	var explosion = player_explosion_scene.instance()
	explosion.position = self.position
	get_parent().add_child(explosion)
	explosion.emitting = true
	
	emit_signal("player_died")
	
	queue_free()
