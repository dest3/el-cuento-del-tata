extends CharacterBody2D


@onready var ligth: CollisionShape2D = $Area2D/ligth
@onready var area_2d: Area2D = $Area2D
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var SPEED = 300.0
@export var jump_force = 300

func _physics_process(delta: float) -> void:
	movement()
	ligth_controler()
	aplly_gravity(delta)
	jump()

func movement():
	#obtiene un vector 2 con el input del jugador
	var direction := Input.get_axis("move_left","move_right") 
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
	#if ligth:
		#var mouse = get_global_mouse_position()
		#area_2d.look_at(mouse)

	if ligth:
		var mouse = get_global_mouse_position()

		# dirección del jugador al mouse
		var direction = mouse - global_position
		
		# obtiene el ángulo hacia el mouse
		var angle = direction.angle()

		# rango permitido (en grados)
		var max_angle = deg_to_rad(10)

		# limitar el ángulo
		angle = clamp(angle, -max_angle, max_angle)

		# aplicar rotación
		area_2d.rotation = angle

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		if body.has_changed == false:
			body.animation_player.play("changing")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Enemy:
		if body.has_changed == false:
			body.animation_player.stop(true)
