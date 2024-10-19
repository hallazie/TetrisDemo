extends Node


@onready var container = $Control/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer


func _ready() -> void:
    for child in container.get_children():
        container.remove_child(child)
    var record_list = EthTool.sync_leaderboard()
    var top_flag = false
    for record in record_list:
        var label = Label.new()
        label.text = str(record.index) + " " + record.name + ": " + str(record.score)
        if record.name == Vars.username:
            label.set("theme_override_colors/font_color", Color(1.0,0.0,0.0,1.0))
            top_flag = true
        container.add_child(label)
    if not top_flag:
        var gap = Label.new()
        gap.text = "..."
        var label = Label.new()
        label.text = "- " + Vars.username + ": " + str(Vars.highest_score)
        label.set("theme_override_colors/font_color", Color(1.0,0.0,0.0,1.0))
        container.add_child(gap)
        container.add_child(label)

func _process(delta: float) -> void:
    if Input.is_action_just_pressed("Pause"):
        get_tree().change_scene_to_file("res://Scenes/menu.tscn")
