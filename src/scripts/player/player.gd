extends CharacterBody2D

@onready var ligth: CollisionShape2D = $ligth

@export var SPEED = 300.0


func _physics_process(delta: float) -> void:
	movement()
	ligth_controler()

func movement():
	#obtiene un vector 2 con el input del jugador
	var direction := Input.get_vector("move_left","move_right","move_up", "move_down") 
	if direction:#si existe input del jugador
		velocity = direction * SPEED# aplica la velocidad de movimiento en la direccion del movimiento 
	else:
		#si no hay input vuelve la velocidad a 0 
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()


func ligth_controler():
	#hace que la luz apunte al mouse todo el tiempo 
	var mouse = get_global_mouse_position()
	ligth.look_at(mouse)
