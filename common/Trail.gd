extends Line2D

var target
var point
export(NodePath) var targetPath
export var trailLength = 0
export var speedY = 0

func _ready() -> void:
	target = get_node(targetPath)

func _process(delta: float) -> void:
	point = target.global_position
	add_point(point)
	while get_point_count() > trailLength:
		remove_point(0)
	for i in range(points.size()):
		set_point_position(i, Vector2(get_point_position(i).x, get_point_position(i).y + (-speedY * delta)))
