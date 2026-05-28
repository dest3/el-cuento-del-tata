extends Node2D

signal dialogo_end
const INTRO = preload("uid://c6o54xrwjdir8")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.dialogue_ended.connect(_on_dialogo_end)
	DialogueManager.show_dialogue_balloon(INTRO,"start") 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_dialogo_end(INTRO):
	get_tree().change_scene_to_file("res://src/scenes/levels/lvl_1.tscn")
