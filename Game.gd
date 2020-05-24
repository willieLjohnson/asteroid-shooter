extends Node2D

func _ready() -> void:
	connect("resized", self, "call_wrap_around")

func call_wrap_around():
	get_tree().call_group("wrap_around", "recalculate_wrap_area")
 

func _on_Player_player_died() -> void:
	$MusicPlayer.stop()
	$MusicPlayer.stream = load("res://assets/audio/music/sawsquarenoise_-_06_-_Towel_Defence_Jingle_Loose.ogg")
	$MusicPlayer.stream.loop = false
	$MusicPlayer.volume_db = -5
	
	$AsteroidSpawner/SpawnTimer.stop()
	
	for asteroid in get_tree().get_nodes_in_group("asteroids"):
		asteroid.get_node("AudioStreamPlayer2D").stop()
	
	$GameOverTimer.start()

func _on_GameOverTimer_timeout() -> void:
	$MusicPlayer.play(0)
	$GameOverLabel.visible = true
