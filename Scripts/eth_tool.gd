extends Node


class Record:
    var name: String = ""
    var score: int = 0
    var index: int = 0

    func _init(name, score):
        self.name = name
        self.score = score


func check_username_available(username):
    """
    检查用户名是否已经被占用，用于进行唯一的全局排名
    """
    # TODO change this
    return randi_range(0, 10) < 5
        

func sync_leaderboard():
    """
    从链上同步战绩，只返回前100名
    """
    # TODO change this to get record_list from chain
    
    # -------------------------------------------
    var alphabet = "qwertyuiopasdfghjklzxcvbnm".split()
    print(alphabet)
    var record_list = []
    for i in range(100):
        var name = ""
        for ii in range(randi_range(5, 10)):
            name += alphabet[randi_range(0, 25)]
        var score = randi_range(10, 100) * 10
        print(name)
        record_list.append(Record.new(name, score))
    record_list.append(Record.new(Vars.username, Vars.highest_score))
    # -------------------------------------------
    
    record_list.sort_custom(func(a, b): return a.score > b.score)
    record_list = record_list.slice(0, 100)
    for i in range(len(record_list)):
        record_list[i].index = i + 1
    return record_list
    
    
func update_user_score(username, score):
    """
    将用户的最高分数同步到链上 
    """
    pass

    
    
