class_name Player
extends CharacterBody2D

@export var acceleration: float = 35.0
@export var max_speed: float = 1000.0
@export var rotation_speed: float = 250.0

func _physics_process(delta):
    # Handle acceleration
    var input_vector: Vector2 = Vector2(0, Input.get_axis("forward", "backward"))

    velocity += input_vector.rotated(rotation) * acceleration
    velocity = velocity.limit_length(max_speed)

    # Decelerate if there is no thrust
    if input_vector.y == 0:
        velocity = velocity.move_toward(Vector2.ZERO, 8)

    # Handle rotation
    if Input.is_action_pressed("left"):
        rotate(deg_to_rad(-rotation_speed * delta))

    if Input.is_action_pressed("right"):
        rotate(deg_to_rad(rotation_speed * delta))

    # Actually move
    move_and_slide()

    # Teleport at the screen edges
    var screen_size = get_viewport_rect().size

    if global_position.y < 0:
        global_position.y = screen_size.y

    if global_position.y > screen_size.y:
        global_position.y = 0

    if global_position.x < 0:
        global_position.x = screen_size.x

    if global_position.x > screen_size.x:
        global_position.x = 0
