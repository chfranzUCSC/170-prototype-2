extends Control


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://play.tscn")


func _on_steal_pressed() -> void:
	get_tree().change_scene_to_file("res://steal.tscn")
