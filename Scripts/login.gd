extends Node


@onready var text_input_box = $Control/PanelContainer/MarginContainer/Control/VBoxContainer/TextEdit


func _on_submit_pressed() -> void:
    if text_input_box.text.length() > 4:
        Vars.create_user_name(text_input_box.text)
    
    
func _process(delta: float) -> void:
    if Input.is_action_just_pressed("Pause"):
        get_tree().change_scene_to_file("res://Scenes/menu.tscn")
