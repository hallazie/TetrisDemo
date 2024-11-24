extends Node


@onready var container = $Control/PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer
@onready var return_button = $Control/PanelContainer/MarginContainer/VBoxContainer/Button


func _ready() -> void:
    for child in container.get_children():
        container.remove_child(child)
    #var record_list = EthTool.sync_leaderboard()
    var record_list = []
    #for i in range(100):
        #record_list.append(EthTool.Record.new(str(i), i))
    var record_chain_list = await EthTool.get_top_scores()
    if len(record_chain_list) > 0:
        var record_dict = {}
        for record_chain in record_chain_list[0]:
            if not record_dict.has(record_chain[0]):
                record_dict[record_chain[0]] = int(record_chain[1])
            else:
                record_dict[record_chain[0]] = max(record_dict[record_chain[0]], int(record_chain[1]))
        for item in record_dict:
            record_list.append(EthTool.Record.new(item, int(record_dict[item])))
        #print("++++dict: ", record_dict)
        #print("++++list: ", record_list)
        record_list.sort_custom(func(a, b): return a.score > b.score)
        record_list = record_list.slice(0, 100)
        for i in range(len(record_list)):
            record_list[i].index = i + 1
    else:
        record_list = []
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


func _on_button_pressed() -> void:
    get_tree().change_scene_to_file("res://Scenes/menu.tscn")
