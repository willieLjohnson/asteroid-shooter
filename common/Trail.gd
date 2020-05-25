extends Line2D

var target
var point
export(NodePath) var targetPath
export var trailLength = 10
export var speedY = 0
export var maxFrames = 15
var speedX = 0
var frameCount = 0

func _ready() -> void:
	target = get_node(targetPath)

func _process(delta: float) -> void:
	point = target.global_position
	add_point(point)
	frameCount %= maxFrames
	while get_point_count() > trailLength:
		remove_point(0)
	for i in range(points.size()):
		if i > 0 and i < trailLength / 4:
			speedX = rand_range(-20, 20)
		elif i > trailLength / 4 + 1 and i < trailLength / 2:
			speedX = rand_range(-50, 50)
		elif i > trailLength / 2 + 1 and i < trailLength * 0.75:
			speedX = rand_range(-150, 150)
		set_point_position(i, Vector2(get_point_position(i).x + (speedX * delta), get_point_position(i).y + (-speedY * delta)))
	
