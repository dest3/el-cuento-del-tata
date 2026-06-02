extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value)


func _on_mute_volume_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,toggled_on)


func _on_full_screen_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		DisplayServer.window_set_mode(3) 
	else:
		DisplayServer.window_set_mode(0) 
		


func _on_resolution_option_item_selected(index: int) -> void:
	match index:
		0: 
			DisplayServer.window_set_size(Vector2i(1152,648))
		1: 
			DisplayServer.window_set_size(Vector2i(1280,720))
		2: 
			DisplayServer.window_set_size(Vector2i(1600,900))
		3: 
			DisplayServer.window_set_size(Vector2i(1920,1080))
