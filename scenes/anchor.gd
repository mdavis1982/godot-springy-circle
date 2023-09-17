extends Area2D

@export var spring_force: float = 8.0
@export var damping: float = 0.9

@onready var start_position: Vector2 = position

var velocity: Vector2 = Vector2.ZERO

func _physics_process(delta):
    position += velocity * delta

    var displacement = position - start_position
    var k = spring_force
    var force = -k * displacement

    velocity += force
    velocity *= damping


func _on_body_entered(body):
    if body is Player:
        velocity = body.velocity * 1.2
