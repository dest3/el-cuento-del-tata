extends CharacterBody2D

@onready var icon: Sprite2D = $Icon
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var ligth: CollisionShape2D = $Area2D/ligth
@onready var area_2d: Area2D = $Area2D
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var SPEED = 300.0
@export var jump_force = 300
var direction:float
func _physics_process(delta: float) -> void:
	movement()
	ligth_controler()
	aplly_gravity(delta)
	jump()
	handle_animations()
	print(velocity.x)

func movement():
	#obtiene un vector 2 con el input del jugador
	direction = Input.get_axis("move_left","move_right") 
	if direction:#si existe input del jugador
		velocity.x = direction * SPEED# aplica la velocidad de movimiento en la direccion del movimiento 
	else:
		#si no hay input vuelve la velocidad a 0 
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func jump():
	if Input.is_action_just_pressed("jump"):
		velocity.y -= jump_force

func aplly_gravity(delta):
	if !is_on_floor():
		velocity.y += gravity * delta

func ligth_controler():
	##hace que la luz apunte al mouse todo el tiempo 
	if ligth:
				# rango permitido (en grados)
		var max_angle = deg_to_rad(15)#limite en el que se puede mover la linterna 

		# dirección del jugador al mouse
		var mouse = get_global_mouse_position() # obtiene el vector2 del mouse
		var direction = mouse - global_position # calcula la diferencia del mouse al jugador
		
		# obtiene el ángulo hacia el mouse
		var angle = direction.angle()

		# limitar el ángulo
		#TODO lerp_angle el valor 
		angle = clamp(angle, -max_angle, max_angle)

		if icon.flip_h == false:
			# aplicar rotación
			area_2d.rotation = angle
		else:
			area_2d.rotation = -angle
			


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		if body.has_changed == false:
			body.animation_player.play("changing")

func _on_area_2d_body_exited(body: Node2D) -> void:
	pass
	#if body is Enemy:
		#if body.has_changed == false:
			#body.animation_player.stop(true

func handle_animations() -> void:
	if velocity.x  > 0 :
		animation_player.play("walk_right")
	
	elif velocity.x < 0:
		animation_player.play("walk_left")
	else:
		animation_player.play("Idle")
	
