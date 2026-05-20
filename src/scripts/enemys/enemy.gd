extends CharacterBody2D

class_name Enemy
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var has_changed = false

const SPEED = 300.0

func _ready() -> void:
	if animation_player:
		animation_player.play("walk")


func _physics_process(delta: float) -> void:
	pass

func change():
	if has_changed == false:
		#sprite_2d.set_modulate(Color(1,1,1,1))
		has_changed = true
