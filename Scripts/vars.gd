extends Node


var username: String = ""
var highest_score: int = 0
var current_score: int = 0
var user_data_pth = "user://user.json"


func _ready() -> void:
    if ResourceLoader.exists(user_data_pth):
        var file = FileAccess.open(user_data_pth, FileAccess.READ).get_as_text()
        var json = JSON.new()
        var data = json.parse_string(file)
        username = data["username"]
        highest_score = data["highest_score"]


func create_user_name(uname):
    username = uname
    var file = FileAccess.open(user_data_pth, FileAccess.WRITE)
    var data = JSON.stringify({"username": username, "highest_score": 0})
    file.store_line(data)
    get_tree().change_scene_to_file("res://Scenes/menu.tscn")
    
    
func update_highest_score():
    if current_score > highest_score:
        highest_score = current_score
        var file = FileAccess.open(user_data_pth, FileAccess.WRITE)
        var data = JSON.stringify({"username": username, "highest_score": current_score})
        file.store_line(data)
