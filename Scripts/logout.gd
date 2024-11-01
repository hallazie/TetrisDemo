extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_confirm_pressed() -> void:
	await Vars.delete_user_info()
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
