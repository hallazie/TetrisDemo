extends Node


@onready var login_button = $Control/PanelContainer/MarginContainer/Control/VBoxContainer/Login
@onready var welcome_label = $Control/PanelContainer/MarginContainer/Control/VBoxContainer/Welcome


func _ready() -> void:
    if Vars.username != null and Vars.username != "":
        login_button.disabled = true
        welcome_label.text = "Welcome, " + Vars.username + "!"
    else:
        welcome_label.text = "Please create a username"


func _on_play_pressed() -> void:
    get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_leaderboard_pressed() -> void:
    get_tree().change_scene_to_file("res://Scenes/leaderboard.tscn")


func _on_login_pressed() -> void:
    if Vars.username == "":
        get_tree().change_scene_to_file("res://Scenes/login.tscn")


func _on_exit_pressed() -> void:
    get_tree().quit()
