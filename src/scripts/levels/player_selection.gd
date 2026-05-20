extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

@export var first_level:PackedScene

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_player_1_pressed() -> void:
	get_tree().change_scene_to_packed(first_level)


func _on_player_2_pressed() -> void:
	get_tree().change_scene_to_packed(first_level)


func _on_player_3_pressed() -> void:
	get_tree().change_scene_to_packed(first_level)
