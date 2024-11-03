extends Node


var username: String = ""
var private_key: String = ""
var highest_score: int = 0
var current_score: int = 0
var user_data_pth = "user://user.json"


func _ready() -> void:
    if ResourceLoader.exists(user_data_pth):
        var file = FileAccess.open(user_data_pth, FileAccess.READ).get_as_text()
        var json = JSON.new()
        var data = json.parse_string(file)
        if "username" in data:
            username = data["username"]
            private_key = data["private_key"]
            var highest_result = await EthTool.get_best_score(username)
            if len(highest_result) > 1 and highest_result[0] == true:
                print("eht result not empty with result: ", highest_result)
                highest_score = int(highest_result[1])
            else:
                highest_score = 0


func reset_score():
    current_score = 0
    if username != "":
        var highest_result = await EthTool.get_best_score(username)
        if len(highest_result) > 1 and highest_result[0] == true:
            highest_score = int(highest_result[1])
        else:
            highest_score = 0
    else:
        highest_score = 0


func create_user_name(uname: String, pkey: String):
    username = uname
    private_key = pkey.strip_edges()
    var file = FileAccess.open(user_data_pth, FileAccess.WRITE)
    var data = JSON.stringify({"username": username, "private_key": private_key})
    file.store_line(data)
    get_tree().change_scene_to_file("res://Scenes/menu.tscn")
    
    
func delete_user_info():
    username = ""
    private_key = ""
    highest_score = 0
    current_score = 0
    var file = FileAccess.open(user_data_pth, FileAccess.WRITE)
    var data = JSON.stringify({})
    file.store_line(data)
    
    
func update_highest_score():
    """
    only update best score from and to chain
    """
    #if current_score > highest_score:
        #highest_score = current_score
        #var file = FileAccess.open(user_data_pth, FileAccess.WRITE)
        #var data = JSON.stringify({"username": username, "private_key": private_key, "highest_score": current_score})
        #file.store_line(data)
    pass
