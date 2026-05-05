extends Control

@export var first_level:PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(first_level)

func _on_quit_pressed() -> void:
	get_tree().quit()
