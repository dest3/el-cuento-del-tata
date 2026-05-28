extends Node2D

const INTRO = preload("uid://c6o54xrwjdir8")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.show_dialogue_balloon(INTRO,"start") 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
