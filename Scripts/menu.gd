extends Node





func _on_play_pressed() -> void:
    get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_leaderboard_pressed() -> void:
    pass # Replace with function body.


func _on_login_pressed() -> void:
    pass # Replace with function body.


func _on_exit_pressed() -> void:
    get_tree().quit()
