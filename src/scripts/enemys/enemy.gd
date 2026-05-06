extends CharacterBody2D

class_name Enemy

@onready var sprite_2d: Sprite2D = $Sprite2D

const SPEED = 300.0

func _physics_process(delta: float) -> void:
	pass

func change():
	sprite_2d.set_modulate(Color(1,1,1,1))
