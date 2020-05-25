extends Line2D

var target
var point
export(NodePath) var targetPath
export var trailLength = 0

func _ready() -> void:
	target = get_node(targetPath)

func _process(delta: float) -> void:
	point = target.global_position
	add_point(point)
	while get_point_count() > trailLength:
		remove_point(0)
	
