extends Node2D


func _ready():
    $Circle.position = get_viewport_rect().get_center()
    $Player.position = get_viewport_rect().get_center()
