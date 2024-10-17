extends CanvasLayer

class_name UI

@onready var center_container = $CenterContainer

var paused = false

func _process(delta: float) -> void:
    if Input.is_action_just_pressed("Pause"):
        if not paused:
            print("pause")
            show()
            center_container.show()            
            paused = true
            # get_tree().paused = true
        else:
            print("continue")
            hide()
            center_container.hide()
            paused = false
            # get_tree().paused = false


func show_game_over():
    show()
    center_container.show()


func _on_button_pressed():
    get_tree().reload_current_scene()


func _on_menu_pressed() -> void:
    get_tree().change_scene_to_file("res://Scenes/menu.tscn")
