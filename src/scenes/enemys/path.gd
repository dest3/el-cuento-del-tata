extends Path2D
@onready var path_follow_2d: PathFollow2D = $PathFollow2D

var active:=true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move()

func move():
	if active:
		path_follow_2d.progress += 10
