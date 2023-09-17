extends Node2D

@export var radius: int = 500
@export var num_points: int = radius / 6

@onready var points: Node = $Points
@onready var point_scene: PackedScene = preload("res://scenes/anchor.tscn")

var line_points: PackedVector2Array = []

func _ready():
    spawnNodes()
    setLinePoints()

func _physics_process(delta):
    queue_redraw()

func _draw():
    setLinePoints()
    smoothLinePoints(line_points)

    draw_polyline(line_points, Color.WHITE, 6.0, true)

func spawnNodes() -> void:
    for i in range(num_points):
        # Calculate the angle between each point
        var angle = i * TAU / num_points

        # Instantiate the point
        var point = point_scene.instantiate()

        # Set up the point
        point.position = Vector2(cos(angle), sin(angle)) * radius

        points.add_child(point)

func setLinePoints() -> void:
    line_points.clear()

    var point_nodes = points.get_children()

    for point_node in point_nodes:
        line_points.append(point_node.position)

    line_points.append(point_nodes[0].position)

func smoothLinePoints(points: PackedVector2Array, num_points: int = 5, corner_speed: float = 4) -> void:
    var curve: Curve2D = Curve2D.new()

    for idx in range(len(points)):
        curve.add_point(points[idx])

        if idx > 0:
            var delta = points[idx] - points[idx-1]
            delta /= corner_speed

            curve.set_point_in(idx, -delta)
            curve.set_point_out(idx, +delta)

    var new_points = curve.tessellate(num_points)

    line_points = new_points
