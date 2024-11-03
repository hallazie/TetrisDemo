extends Node

class_name Board

signal tetromino_locked
signal game_over

@onready var panel_container = $"../NextTetro/MarginContainer"
@onready var personal_best_label = $"../ScoreBoard/MarginContainer/VBoxContainer/PersonalBestScore"
@onready var current_score_label = $"../ScoreBoard/MarginContainer/VBoxContainer/CurrentScore"

@onready var line_scene = preload("res://Scenes/line.tscn")


const ROW_COUNT = 20
const COLUMN_COUNT = 10

var current_score = 0

var next_tetromino
var tetrominos: Array[Tetromino] = []
@export var tetromino_scene: PackedScene


func _ready() -> void:
    current_score = 0
    personal_best_label.text = str(Vars.highest_score)
    current_score_label.text = str(current_score)


func spawn_tetromino(type: Shared.Tetromino, is_next_piece, spawn_position):
    var tetromino_data = Shared.data[type]
    var tetromino = tetromino_scene.instantiate() as Tetromino
    
    tetromino.tetromino_data = tetromino_data
    tetromino.is_next_piece = is_next_piece
    
    if is_next_piece == false:
        var other_pieces = get_all_pieces()
        tetromino.position = tetromino_data.spawn_position
        tetromino.other_tetrominoes_pieces = other_pieces
        add_child(tetromino)
        tetromino.lock_tetromino.connect(on_tetromino_locked)
    else: 
        tetromino.scale = Vector2(0.5, 0.5)
        panel_container.add_child(tetromino)
        tetromino.set_position(spawn_position)
        next_tetromino = tetromino
        

func on_tetromino_locked(tetromino: Tetromino):
    next_tetromino.queue_free()
    tetrominos.append(tetromino)
    add_tetromino_to_lines(tetromino)
    remove_full_lines()
    tetromino_locked.emit()
    check_game_over()

    
func check_game_over():
        for piece in get_all_pieces():
            var y_location = piece.global_position.y
            if y_location == -456:
                game_over.emit()
                Vars.update_highest_score()
                
    
func add_tetromino_to_lines(tetromino: Tetromino):
    var tetromino_pieces = tetromino.get_children().filter(func (c): return c is Piece)
    for piece in tetromino_pieces:
        var y_position = piece.global_position.y
        var does_line_for_piece_exists = false
        
        for line in get_lines():
            
            if line.global_position.y == y_position:
                piece.reparent(line)
                does_line_for_piece_exists = true
        
        if !does_line_for_piece_exists:
            var piece_line = line_scene.instantiate() as Line
            piece_line.global_position = Vector2(0, y_position)
            add_child(piece_line)
            piece.reparent(piece_line)


func get_lines():
    return get_children().filter(func (c): return c is Line)


func remove_full_lines():
    var line_cnt = 0
    for line in get_lines():
        if line.is_line_full(COLUMN_COUNT):
            move_lines_down(line.global_position.y)
            line.free()
            line_cnt += 1
    if line_cnt == 0:
        pass
    elif line_cnt == 1:
        current_score += 40
    elif line_cnt == 2:
        current_score += 100
    elif line_cnt == 3:
        current_score += 300
    elif line_cnt == 4:
        current_score += 1200
    else:
        current_score += 1200
    Vars.current_score = current_score
    current_score_label.text = str(current_score)
    

func move_lines_down(y_position):
    for line in get_lines():
        if line.global_position.y < y_position:
            line.global_position.y += 48

func get_all_pieces():
    var pieces = []
    for line in get_lines():
        pieces.append_array(line.get_children())
    return pieces
