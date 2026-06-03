extends Control

@onready var input_button_scene = preload("res://src/scenes/menu/input_button.tscn")
@onready var action_list = $PanelContainer/MarginContainer/VBoxContainer2/MarginContainer/VBoxContainer/ScrollContainer/Action_list

var is_remapping = false
var action_to_remap : StringName 
var remaping_button : Button = null
var input_actions ={
	"move_right": "derecha",
	"move_left": "izquierda",
	"move_up": "saltar",
	"move_down": "abajo",
	}
func _ready() -> void:
	_create_action_list()

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

func _create_action_list():
	#limpia todos los botones creados en el menu de config
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
	#recorre el diccionario de acciones y instancia un boton por cada uno
	for action in input_actions:
		var button = input_button_scene.instantiate()
		var action_label = button.find_child("Label_action")#obtiene el acceso al label 
		var input_label = button.find_child("Input_key")
		
		action_label.text = input_actions[action]#cambia el texto del label por el item correspondiente a la accion en el diccionario 
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:#si hay alguna accion
			input_label.text = events[0].as_text().trim_suffix(" - Physical")#asigna el nombre de la tecla asociada a la accion
		else:
			input_label.text = "" #si no hay tecla asignada deja el espacio en blanco
		action_list.add_child(button)#agrega el boton a la lista de ui
		button.pressed.connect(_on_input_button_pressed.bind(button, action))


func _on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remaping_button = button

		button.find_child("Input_key").text = "press key to bind..."


func _input(event) -> void:
	if is_remapping:
		if event is InputEventKey && event.pressed:
			InputMap.action_erase_event(action_to_remap,event)
			InputMap.action_add_event(action_to_remap,event)
			_update_action_list(remaping_button, event)
			
			is_remapping = false
			action_to_remap = ""
			remaping_button = null
			
			accept_event()

func _update_action_list(button, event):
	button.find_child("Input_key").text = event.as_text().trim_suffix(" (Physical)")


func _on_back_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/menu/Main_menu.tscn")
