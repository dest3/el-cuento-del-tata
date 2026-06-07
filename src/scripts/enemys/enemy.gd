extends CharacterBody2D

class_name Enemy
@onready var timer: Timer = $Timer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var speed:float = 300.0
@export var waypoints: Array[Marker2D]

var current_index := 0
var is_waiting := false
var has_changed = false

func _ready() -> void:
	if animation_player:
		animation_player.play("walk")

func _physics_process(delta: float) -> void:
	follow_waypoints()

#trigers the animation to change
func change():
	if has_changed == false:
		#sprite_2d.set_modulate(Color(1,1,1,1))
		has_changed = true

func follow_waypoints()-> void:
		if is_waiting:
			return
		else:
			var min_distance = 5.0
			var target_position = waypoints[current_index].global_position
			var direction = target_position - global_position
			var distance = direction.length()
			direction = direction.normalized()
			velocity = direction * speed
			move_and_slide()
			
			if distance < min_distance:
				current_index += 1
				velocity = Vector2.ZERO
				timer.start()
				is_waiting = true
				if current_index >= waypoints.size():
					current_index = 0


func _on_timer_timeout() -> void:
	is_waiting = false
