extends CanvasLayer

class_name UI

@onready var center_container = $CenterContainer
@onready var submit_button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Submit


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
    if Vars.username == "":
        submit_button.text = "Login to Submit Score"
        submit_button.disabled = true
    else:
        submit_button.text = "Submit to Leaderboard"
        submit_button.disabled = false
    show()
    center_container.show()


func _on_button_pressed():
    get_tree().reload_current_scene()
    Vars.reset_score()


func _on_menu_pressed() -> void:
    Vars.update_highest_score()
    for child in get_tree().root.get_children():
        if child.name.begins_with("@Node") or child.name.begins_with("ghost"):
            child.queue_free()
    get_tree().change_scene_to_file("res://Scenes/menu.tscn")
    Vars.reset_score()


func _on_submit_pressed() -> void:
    await EthTool.upload_score(Vars.username, Vars.current_score, Vars.private_key)
    Vars.reset_score()
    get_tree().change_scene_to_file("res://Scenes/menu.tscn")
